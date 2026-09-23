#!/usr/bin/env bash

if [ -z "${BASH_VERSION:-}" ]; then
	exec bash "$0" "$@"
fi

set -euo pipefail

SCRIPT_PATH="${BASH_SOURCE[0]:-}"
SCRIPT_DIR="$(cd "$(dirname "${SCRIPT_PATH:-.}")" && pwd)"

bootstrap_repository() {
	command -v git >/dev/null 2>&1 || {
		echo "git is required to download zed-101-setup." >&2
		exit 1
	}

	TEMPORARY_DIRECTORY="$(mktemp -d)"
	trap 'rm -rf "$TEMPORARY_DIRECTORY"' EXIT INT TERM

	echo "Downloading zed-101-setup..."
	GIT_TERMINAL_PROMPT=0 git -c credential.helper= clone --depth 1 \
		https://github.com/jellydn/zed-101-setup.git "$TEMPORARY_DIRECTORY"
	bash "$TEMPORARY_DIRECTORY/install.sh" "$@"
}

if [[ -z "$SCRIPT_PATH" || ! -f "$SCRIPT_DIR/lib/zed-config.sh" ]]; then
	bootstrap_repository "$@"
	exit 0
fi

source "$SCRIPT_DIR/lib/zed-config.sh"

usage() {
	cat <<'EOF'
Usage: ./install.sh [--dry-run] [--no-backup]

Install settings.json, keymap.json, and tasks.json from this repository into
Zed. Existing files are backed up by default.

Options:
  --dry-run    Show the operations without changing files.
  --no-backup  Overwrite existing files without creating a backup.
  -h, --help   Show this help.

Set ZED_CONFIG_DIR to override the platform default configuration directory.
EOF
}

DRY_RUN=false
CREATE_BACKUP=true

for argument in "$@"; do
	case "$argument" in
	--dry-run) DRY_RUN=true ;;
	--no-backup) CREATE_BACKUP=false ;;
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

require_managed_files "$SCRIPT_DIR"
CONFIG_DIRECTORY="$(zed_config_directory)"
BACKED_UP=false

if [[ "$CREATE_BACKUP" == "true" ]]; then
	for relative_path in "${MANAGED_FILES[@]}"; do
		if [[ -f "$CONFIG_DIRECTORY/$relative_path" ]]; then
			BACKED_UP=true
			break
		fi
	done

	if [[ "$BACKED_UP" == "true" ]]; then
		BACKUP_TEMPLATE="$CONFIG_DIRECTORY/backup-$(date +%Y%m%d-%H%M%S)-XXXXXX"
		if [[ "$DRY_RUN" == "true" ]]; then
			BACKUP_DIRECTORY="$BACKUP_TEMPLATE"
		else
			BACKUP_DIRECTORY="$(mktemp -d "$BACKUP_TEMPLATE")"
		fi

		for relative_path in "${MANAGED_FILES[@]}"; do
			if [[ ! -f "$CONFIG_DIRECTORY/$relative_path" ]]; then
				continue
			fi
			copy_managed_file \
				"$CONFIG_DIRECTORY/$relative_path" \
				"$BACKUP_DIRECTORY/$relative_path"
		done
	fi
fi

for relative_path in "${MANAGED_FILES[@]}"; do
	copy_managed_file \
		"$SCRIPT_DIR/$relative_path" \
		"$CONFIG_DIRECTORY/$relative_path"
done

if [[ "$BACKED_UP" == "true" ]]; then
	if [[ "$DRY_RUN" == "true" ]]; then
		printf 'Would save backup to: %s\n' "$BACKUP_DIRECTORY"
	else
		printf 'Backup saved to: %s\n' "$BACKUP_DIRECTORY"
		printf 'To restore: cp -p "%s"/*.json "%s/"\n' "$BACKUP_DIRECTORY" "$CONFIG_DIRECTORY"
	fi
fi

if [[ "$DRY_RUN" == "true" ]]; then
	echo "Dry run complete. No files changed."
else
	echo "Installation complete."
fi
