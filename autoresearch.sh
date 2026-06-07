#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
KEYMAP="$ROOT/keymap.json"

if [[ ! -f "$KEYMAP" ]]; then
  echo "METRIC companion_score=0"
  echo "METRIC ai_bindings=0"
  exit 1
fi

eval "$(python3 <<PY
import json, re
from pathlib import Path
p = Path("$KEYMAP")
raw = p.read_text()
lines = []
for line in raw.splitlines():
    if '//' in line:
        line = line.split('//', 1)[0]
    lines.append(line)
text = '\n'.join(lines)
text = re.sub(r'/\*.*?\*/', '', text, flags=re.S)
data = json.loads(text)
checks = {
    'space a c': 1,
    'space a a': 2,
    'space a s': 2,
    'space a S': 3,
    'space a g': 2,
    'space a N': 2,
    'space a o': 2,
    'space a b': 3,
    'space a i': 2,
    'space a p': 2,
    'space a h': 2,
    'space a G': 2,
    'space a P': 2,
    'space a /': 2,
    'space a w': 2,
    'space a u': 2,
    'space a j': 2,
    'space a x': 2,
    'space a E': 3,
    'space a F': 3,
    'space a T': 3,
    'space a k': 2,
    'space a y': 2,
    'space a q': 2,
    'space a O': 3,
    'space a Q': 3,
    'space a z': 3,
    'space a v': 2,
    'space a e': 3,
    'space a f': 3,
    'space a l': 3,
    'space a t': 3,
    'space a m': 2,
    'space a d': 3,
    'space a D': 3,
    'space a r': 3,
    'space a R': 3,
    'space a n': 3,
}
score = 0
ai_bindings = 0
for block in data:
    b = block.get('bindings') or {}
    for key in b:
        if not key.startswith('space a'):
            continue
        ai_bindings += 1
        score += checks.get(key, 0)
print(f'companion_score={score}')
print(f'ai_bindings={ai_bindings}')
PY
)"

echo "METRIC companion_score=${companion_score}"
echo "METRIC ai_bindings=${ai_bindings}"