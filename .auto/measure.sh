#!/bin/bash
set -euo pipefail

# Measure: AI keybindings and agent bindings count
# Handles JSONC (comments, trailing commas) for keymap.json only

cd "$(dirname "$0")/.."

python3 << 'PYEOF'
import json, re

def parse_jsonc(path):
    with open(path) as f:
        text = f.read()
    # Remove block comments
    text = re.sub(r'/\*.*?\*/', '', text, flags=re.DOTALL)
    # Remove line comments
    text = re.sub(r'//.*?(?:\n|$)', '\n', text)
    # Strip trailing commas before closing } or ]
    text = re.sub(r',\s*\}', '}', text)
    text = re.sub(r',\s*\]', ']', text)
    return json.loads(text)

data = parse_jsonc('keymap.json')

# Count inline assist bindings with custom prompts
ai_with_prompt = 0
for entry in data:
    bindings = entry.get('bindings', {})
    for key, val in bindings.items():
        if isinstance(val, list) and len(val) > 0 and val[0] == 'assistant::InlineAssist':
            if len(val) > 1 and isinstance(val[1], dict) and 'prompt' in val[1]:
                ai_with_prompt += 1

# Count agent::* bindings (agent panel actions)
agent_count = 0
for entry in data:
    bindings = entry.get('bindings', {})
    for key, val in bindings.items():
        if isinstance(val, str) and val.startswith('agent::'):
            agent_count += 1

print(f'METRIC ai_keybindings_count={ai_with_prompt}')
print(f'METRIC agent_keybindings_count={agent_count}')
PYEOF

# Check biome
if bun run lint 2>/dev/null; then
  echo "METRIC biome_ok=1"
else
  echo "METRIC biome_ok=0"
fi
