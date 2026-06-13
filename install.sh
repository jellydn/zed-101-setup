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
		cp -p "${ZED_CONFIG_DIR}/${f}" "${BACKUP_DIR}/${f}"
		echo "  Backed up ${f}"
	fi

	# Install from repo if the file exists here
	if [ -f "${f}" ]; then
		cp -p "${f}" "${ZED_CONFIG_DIR}/${f}"
		echo "  Installed ${f}"
	else
		echo "  Warning: ${f} not found in repo — skipping install"
	fi
done

# Back up and install agent rules
RULES_DIR=".zed/rules"
if [ -d "${RULES_DIR}" ]; then
	if [ -d "${ZED_CONFIG_DIR}/.zed/rules" ]; then
		mkdir -p "${BACKUP_DIR}/.zed-rules"
		cp -p "${ZED_CONFIG_DIR}/.zed/rules"/*.md "${BACKUP_DIR}/.zed-rules/" 2>/dev/null || true
		echo "  Backed up .zed/rules/"
	fi
	mkdir -p "${ZED_CONFIG_DIR}/.zed/rules"
	cp -p "${RULES_DIR}"/*.md "${ZED_CONFIG_DIR}/.zed/rules/"
	echo "  Installed .zed/rules/"
fi

echo ""
echo "Done! Backup saved to: ${BACKUP_DIR}"
echo "To restore configs: cp -p \"${BACKUP_DIR}\"/*.json \"${ZED_CONFIG_DIR}/\""
echo "To restore rules:   cp -p \"${BACKUP_DIR}/.zed-rules\"/*.md \"${ZED_CONFIG_DIR}/.zed/rules/\""
