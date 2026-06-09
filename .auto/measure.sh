#!/bin/bash
set -euo pipefail

# Measure: AI keybindings and agent bindings count
# Parses keymap.json for assistant::InlineAssist with non-empty custom prompts

KEYMAP="keymap.json"

# Count unique inline assist bindings with custom prompts
# These are entries like: "space a e": ["assistant::InlineAssist", {"prompt": "..."}]
ai_count=$(grep -c '"assistant::InlineAssist"' "$KEYMAP" || true)
# Count only the ones that have a "prompt" key in their args (not bare InlineAssist)
ai_with_prompt=$(python3 -c "
import json
with open('$KEYMAP') as f:
    data = json.load(f)
count = 0
for entry in data:
    bindings = entry.get('bindings', {})
    for key, val in bindings.items():
        if isinstance(val, list) and len(val) > 0 and val[0] == 'assistant::InlineAssist':
            if len(val) > 1 and isinstance(val[1], dict) and 'prompt' in val[1]:
                count += 1
print(count)
")

# Count agent::* bindings (agent panel actions)
agent_count=$(python3 -c "
import json
with open('$KEYMAP') as f:
    data = json.load(f)
count = 0
for entry in data:
    bindings = entry.get('bindings', {})
    for key, val in bindings.items():
        if isinstance(val, str) and val.startswith('agent::'):
            count += 1
print(count)
")

# Check biome
cd "$(dirname "$0")/.."
if bun run lint 2>/dev/null; then
  biome_ok=1
else
  biome_ok=0
fi

echo "METRIC ai_keybindings_count=$ai_with_prompt"
echo "METRIC agent_keybindings_count=$agent_count"
echo "METRIC biome_ok=$biome_ok"
