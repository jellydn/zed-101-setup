#!/bin/bash
set -euo pipefail

ZED_CONFIG_DIR="${HOME}/.config/zed"
BACKUP_DIR="${ZED_CONFIG_DIR}/backup-$(date +%Y%m%d-%H%M%S)"

# Files to install from repo to Zed config
FILES=(settings.json keymap.json tasks.json)

# Create backup directory
mkdir -p "${BACKUP_DIR}"

echo "Backing up current Zed config to ${BACKUP_DIR}..."

for f in "${FILES[@]}"; do
	# Backup existing config if it exists
	if [ -f "${ZED_CONFIG_DIR}/${f}" ]; then
		cp "${ZED_CONFIG_DIR}/${f}" "${BACKUP_DIR}/${f}"
		echo "  Backed up ${f}"
	fi

	# Install from repo if the file exists here
	if [ -f "${f}" ]; then
		cp "${f}" "${ZED_CONFIG_DIR}/${f}"
		echo "  Installed ${f}"
	else
		echo "  Warning: ${f} not found in repo — skipping install"
	fi
done

echo ""
echo "Done! Backup saved to: ${BACKUP_DIR}"
echo "To restore, run: cp ${BACKUP_DIR}/* ${ZED_CONFIG_DIR}/"
