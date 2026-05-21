#!/bin/bash

# Copy settings.json
echo "Copying settings.json..."
cp ~/.config/zed/settings.json settings.json

# Copy keymap.json
echo "Copying keymap.json..."
cp ~/.config/zed/keymap.json keymap.json

# Copy tasks.json
echo "Copying tasks.json..."
cp ~/.config/zed/tasks.json tasks.json

# Run cli.ts
echo "Running cli.ts..."
bun run cli.ts
