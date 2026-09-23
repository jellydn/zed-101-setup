#!/usr/bin/env bash

MANAGED_FILES=(
	"settings.json"
	"keymap.json"
	"tasks.json"
)

zed_config_directory() {
	if [[ -n "${ZED_CONFIG_DIR:-}" ]]; then
		printf '%s\n' "$ZED_CONFIG_DIR"
		return
	fi

	case "$(uname -s)" in
	Linux) printf '%s/zed\n' "${XDG_CONFIG_HOME:-$HOME/.config}" ;;
	Darwin) printf '%s/.config/zed\n' "$HOME" ;;
	*)
		echo "Unsupported platform. Set ZED_CONFIG_DIR to your Zed configuration directory." >&2
		return 1
		;;
	esac
}

require_managed_files() {
	local directory="$1"
	local missing=false
	local relative_path

	for relative_path in "${MANAGED_FILES[@]}"; do
		if [[ ! -f "$directory/$relative_path" ]]; then
			echo "Required file not found: $directory/$relative_path" >&2
			missing=true
		fi
	done

	[[ "$missing" == "false" ]]
}

copy_managed_file() {
	local source="$1"
	local destination="$2"

	if [[ "${DRY_RUN:-false}" == "true" ]]; then
		printf 'Would copy: %s -> %s\n' "$source" "$destination"
		return
	fi

	mkdir -p "$(dirname "$destination")"
	cp -p "$source" "$destination"
	printf 'Copied: %s -> %s\n' "$source" "$destination"
}
