#!/usr/bin/env bash

set -euo pipefail

ROOT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEST_DIRECTORY="$(mktemp -d)"
trap 'rm -rf "$TEST_DIRECTORY"' EXIT INT TERM

fail() {
	echo "FAIL: $1" >&2
	exit 1
}

assert_content() {
	local expected="$1"
	local file="$2"
	local actual

	[[ -f "$file" ]] || fail "Expected file: $file"
	actual="$(cat "$file")"
	[[ "$actual" == "$expected" ]] || fail "Unexpected content in $file"
}

copy_scripts() {
	local repository="$1"

	mkdir -p "$repository/lib"
	cp "$ROOT_DIRECTORY/install.sh" "$ROOT_DIRECTORY/generate.sh" "$ROOT_DIRECTORY/cli.ts" "$repository/"
	cp "$ROOT_DIRECTORY/lib/zed-config.sh" "$repository/lib/"
}

write_managed_files() {
	local directory="$1"
	local prefix="$2"
	local file

	mkdir -p "$directory"
	for file in settings.json keymap.json tasks.json; do
		printf '%s %s' "$prefix" "$file" >"$directory/$file"
	done
}

test_install_and_backup() {
	local repository="$TEST_DIRECTORY/install repository"
	local config_directory="$TEST_DIRECTORY/install home/.config/zed"
	local backups
	local file

	copy_scripts "$repository"
	write_managed_files "$repository" "repository"
	write_managed_files "$config_directory" "local"

	ZED_CONFIG_DIR="$config_directory" bash "$repository/install.sh" >/dev/null

	for file in settings.json keymap.json tasks.json; do
		assert_content "repository $file" "$config_directory/$file"
	done

	backups=("$config_directory"/backup-*)
	[[ ${#backups[@]} -eq 1 ]] || fail "Expected one backup directory"
	for file in settings.json keymap.json tasks.json; do
		assert_content "local $file" "${backups[0]}/$file"
	done
}

test_install_dry_run() {
	local repository="$TEST_DIRECTORY/dry install repository"
	local config_directory="$TEST_DIRECTORY/dry install home/.config/zed"
	local output
	local -a backups

	copy_scripts "$repository"
	write_managed_files "$repository" "repository"
	write_managed_files "$config_directory" "local"

	output="$(ZED_CONFIG_DIR="$config_directory" bash "$repository/install.sh" --dry-run)"
	assert_content "local settings.json" "$config_directory/settings.json"
	shopt -s nullglob
	backups=("$config_directory"/backup-*)
	shopt -u nullglob
	[[ ${#backups[@]} -eq 0 ]] || fail "Dry run created a backup"
	[[ "$output" == *"Dry run complete. No files changed."* ]] || fail "Dry run did not report its result"
}

test_install_preflight_and_copy_failure() {
	local repository="$TEST_DIRECTORY/failing install repository"
	local config_directory="$TEST_DIRECTORY/failing install home/.config/zed"
	local blocked_directory="$TEST_DIRECTORY/blocked config"

	copy_scripts "$repository"
	write_managed_files "$repository" "repository"
	write_managed_files "$config_directory" "local"
	rm "$repository/tasks.json"

	if ZED_CONFIG_DIR="$config_directory" bash "$repository/install.sh" >/dev/null 2>&1; then
		fail "install.sh accepted an incomplete repository"
	fi
	assert_content "local settings.json" "$config_directory/settings.json"

	printf 'not a directory' >"$blocked_directory"
	printf 'repository tasks.json' >"$repository/tasks.json"
	if ZED_CONFIG_DIR="$blocked_directory" bash "$repository/install.sh" --no-backup >/dev/null 2>&1; then
		fail "install.sh ignored a destination creation failure"
	fi
}

test_bootstrap_install() {
	local downloaded_directory="$TEST_DIRECTORY/downloaded"
	local fixture_repository="$TEST_DIRECTORY/bootstrap fixture"
	local fake_bin="$TEST_DIRECTORY/bootstrap bin"
	local config_directory="$TEST_DIRECTORY/bootstrap home/.config/zed"

	copy_scripts "$fixture_repository"
	write_managed_files "$fixture_repository" "remote"
	mkdir -p "$downloaded_directory" "$fake_bin"
	cp "$ROOT_DIRECTORY/install.sh" "$downloaded_directory/install.sh"
	cat >"$fake_bin/git" <<'EOF'
#!/usr/bin/env bash
destination="${@: -1}"
cp -R "$BOOTSTRAP_FIXTURE"/. "$destination/"
EOF
	chmod +x "$fake_bin/git"

	BOOTSTRAP_FIXTURE="$fixture_repository" \
		PATH="$fake_bin:$PATH" \
		ZED_CONFIG_DIR="$config_directory" \
		bash "$downloaded_directory/install.sh" --no-backup >/dev/null

	assert_content "remote settings.json" "$config_directory/settings.json"
}

test_standalone_help_does_not_clone() {
	local downloaded_directory="$TEST_DIRECTORY/help download"
	local fake_bin="$TEST_DIRECTORY/help bin"

	mkdir -p "$downloaded_directory" "$fake_bin"
	cp "$ROOT_DIRECTORY/install.sh" "$downloaded_directory/install.sh"
	cat >"$fake_bin/git" <<'EOF'
#!/usr/bin/env bash
exit 99
EOF
	chmod +x "$fake_bin/git"

	PATH="$fake_bin:$PATH" bash "$downloaded_directory/install.sh" --help >/dev/null
}

create_fake_bun() {
	local fake_bin="$1"

	mkdir -p "$fake_bin"
	cat >"$fake_bin/bun" <<'EOF'
#!/usr/bin/env bash
if [[ -n "${BUN_MARKER:-}" ]]; then
	printf 'called' >"$BUN_MARKER"
fi
exit "${BUN_EXIT:-0}"
EOF
	chmod +x "$fake_bin/bun"
}

test_generate() {
	local repository="$TEST_DIRECTORY/generate repository"
	local config_directory="$TEST_DIRECTORY/generate home/.config/zed"
	local fake_bin="$TEST_DIRECTORY/generate bin"
	local marker="$TEST_DIRECTORY/bun marker"
	local file

	copy_scripts "$repository"
	write_managed_files "$repository" "repository"
	write_managed_files "$config_directory" "local"
	create_fake_bun "$fake_bin"

	PATH="$fake_bin:$PATH" BUN_MARKER="$marker" ZED_CONFIG_DIR="$config_directory" \
		bash "$repository/generate.sh" >/dev/null

	for file in settings.json keymap.json tasks.json; do
		assert_content "local $file" "$repository/$file"
	done
	assert_content "called" "$marker"
}

test_generate_dry_run_and_failures() {
	local repository="$TEST_DIRECTORY/dry generate repository"
	local config_directory="$TEST_DIRECTORY/dry generate home/.config/zed"
	local fake_bin="$TEST_DIRECTORY/failing bun bin"
	local output

	copy_scripts "$repository"
	write_managed_files "$repository" "repository"
	write_managed_files "$config_directory" "local"

	output="$(ZED_CONFIG_DIR="$config_directory" bash "$repository/generate.sh" --dry-run)"
	assert_content "repository settings.json" "$repository/settings.json"
	[[ "$output" == *"Would regenerate README.md."* ]] || fail "Dry run omitted README generation"

	rm "$config_directory/tasks.json"
	create_fake_bun "$fake_bin"
	PATH="$fake_bin:$PATH" ZED_CONFIG_DIR="$config_directory" \
		bash "$repository/generate.sh" >/dev/null
	assert_content "local settings.json" "$repository/settings.json"
	assert_content "repository tasks.json" "$repository/tasks.json"

	printf 'local tasks.json' >"$config_directory/tasks.json"
	if PATH="$fake_bin:$PATH" BUN_EXIT=23 ZED_CONFIG_DIR="$config_directory" \
		bash "$repository/generate.sh" >/dev/null 2>&1; then
		fail "generate.sh ignored a README generation failure"
	fi
}

test_cli_failure_status() {
	local repository="$TEST_DIRECTORY/missing cli inputs"

	mkdir -p "$repository"
	cp "$ROOT_DIRECTORY/cli.ts" "$repository/"
	if (cd "$repository" && bun run cli.ts >/dev/null 2>&1); then
		fail "cli.ts reported success with missing required files"
	fi
}

test_cli_formatter_failure() {
	local repository="$TEST_DIRECTORY/formatter failure repository"
	local fake_bin="$TEST_DIRECTORY/formatter failure bin"
	local output

	mkdir -p "$repository" "$fake_bin"
	cp "$ROOT_DIRECTORY/cli.ts" "$repository/"
	write_managed_files "$repository" "configuration"
	cat >"$repository/README.md" <<'EOF'
<!-- ALL-SETTINGS:START --><!-- ALL-SETTINGS:END -->
<!-- ALL-KEYMAPS:START --><!-- ALL-KEYMAPS:END -->
<!-- ALL-TASKS:START --><!-- ALL-TASKS:END -->
EOF
	cat >"$fake_bin/prettier" <<'EOF'
#!/usr/bin/env bash
exit 9
EOF
	chmod +x "$fake_bin/prettier"

	if output="$(cd "$repository" && PATH="$fake_bin:$PATH" bun run cli.ts 2>&1)"; then
		fail "cli.ts ignored a formatter failure"
	fi
	[[ $'\n'"$output"$'\n' != *$'\nDone\n'* ]] || fail "cli.ts reported success after a formatter failure"
}

test_same_file_copy() {
	local source="$TEST_DIRECTORY/same file source"
	local destination="$TEST_DIRECTORY/same file destination"

	printf 'unchanged' >"$source"
	ln "$source" "$destination"
	(
		source "$ROOT_DIRECTORY/lib/zed-config.sh"
		DRY_RUN=false
		copy_managed_file "$source" "$destination" >/dev/null
	)
	assert_content "unchanged" "$source"
}

bash -n "$ROOT_DIRECTORY/install.sh" "$ROOT_DIRECTORY/generate.sh" "$ROOT_DIRECTORY/lib/zed-config.sh"
test_install_and_backup
test_install_dry_run
test_install_preflight_and_copy_failure
test_bootstrap_install
test_standalone_help_does_not_clone
test_generate
test_generate_dry_run_and_failures
test_cli_failure_status
test_cli_formatter_failure
test_same_file_copy

echo "Script tests passed."
