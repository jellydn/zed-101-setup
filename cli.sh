#!/bin/bash
set -euo pipefail

ZED_CONFIG_DIR="${HOME}/.config/zed"

# Check that Zed config files exist before copying
for f in settings.json keymap.json; do
	if [ ! -f "${ZED_CONFIG_DIR}/${f}" ]; then
		echo "Warning: ${ZED_CONFIG_DIR}/${f} not found — skipping"
		continue
	fi
	echo "Copying ${f}..."
	cp "${ZED_CONFIG_DIR}/${f}" "${f}"
done

# Copy tasks.json if it exists
if [ -f "${ZED_CONFIG_DIR}/tasks.json" ]; then
	echo "Copying tasks.json..."
	cp "${ZED_CONFIG_DIR}/tasks.json" tasks.json
else
	echo "Warning: ${ZED_CONFIG_DIR}/tasks.json not found — skipping"
fi

# Run cli.ts
if [ -f cli.ts ]; then
	echo "Running cli.ts..."
	bun run start
else
	echo "Warning: cli.ts not found — skipping README generation"
fi
