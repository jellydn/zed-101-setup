#!/usr/bin/env bash

if [ -z "${BASH_VERSION:-}" ]; then
	exec bash "$0" "$@"
fi

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/zed-config.sh"

usage() {
	cat <<'EOF'
Usage: ./generate.sh [--dry-run]

Export settings.json, keymap.json, and tasks.json from Zed into this
repository, then regenerate the embedded README configuration.

Options:
  --dry-run   Show the operations without changing files.
  -h, --help  Show this help.

Set ZED_CONFIG_DIR to override the platform default configuration directory.
EOF
}

DRY_RUN=false

for argument in "$@"; do
	case "$argument" in
	--dry-run) DRY_RUN=true ;;
	-h | --help)
		usage
		exit 0
		;;
	*)
		echo "Unknown option: $argument" >&2
		usage >&2
		exit 1
		;;
	esac
done

CONFIG_DIRECTORY="$(zed_config_directory)"
require_files "$CONFIG_DIRECTORY" "${REQUIRED_ZED_FILES[@]}"

if [[ "$DRY_RUN" == "false" ]]; then
	command -v bun >/dev/null 2>&1 || {
		echo "bun is required to regenerate README.md." >&2
		exit 1
	}
	[[ -f "$SCRIPT_DIR/cli.ts" ]] || {
		echo "Required file not found: $SCRIPT_DIR/cli.ts" >&2
		exit 1
	}
fi

for relative_path in "${MANAGED_FILES[@]}"; do
	if [[ ! -f "$CONFIG_DIRECTORY/$relative_path" ]]; then
		printf 'Skipped (not found): %s\n' "$CONFIG_DIRECTORY/$relative_path"
		continue
	fi
	copy_managed_file \
		"$CONFIG_DIRECTORY/$relative_path" \
		"$SCRIPT_DIR/$relative_path"
done

if [[ "$DRY_RUN" == "true" ]]; then
	echo "Would regenerate README.md."
	echo "Dry run complete. No files changed."
else
	(cd "$SCRIPT_DIR" && bun run start)
	echo "Generation complete. Review changes with: git diff"
fi
