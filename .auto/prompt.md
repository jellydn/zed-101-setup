# Autoresearch: Extend AI Usage like sidekick.nvim

## Objective

Extend the Zed editor AI configuration to match the rich, context-aware AI interaction patterns from [folke/sidekick.nvim](https://github.com/folke/sidekick.nvim). This means adding more inline assist prompt presets (optimize, security, changes, convert, etc.), structured agent keybindings, and richer prompts that leverage Zed's capabilities — making AI interactions feel as seamless as sidekick.nvim's Neovim experience.

## Metrics

- **Primary**: ai_keybindings_count (count, higher is better) — number of unique `assistant::InlineAssist` keybindings with non-empty custom prompts in `keymap.json`. More prompts = richer AI interaction palette.
- **Secondary**: agent_keybindings_count (count, higher is better) — number of `agent::*` keybinding actions. Measures agent panel integration depth.
- **Secondary**: biome_ok (boolean, 1=pass) — biome check passes (lint + format).

## How to Run

`./.auto/measure.sh` — outputs `METRIC name=number` lines.

## Files in Scope

- `settings.json` — Zed settings (agent config, inline_assistant_model, favorite_models)
- `keymap.json` — Key bindings (all `assistant::InlineAssist` and `agent::*` bindings are here)
- `README.md` — Generated from source (regenerated via `bun run start`)
- `cli.ts` — README generation logic

## Off Limits

- Do NOT modify `cli.ts` (README generation logic) unless it directly blocks our goal
- Do NOT touch `.github/`, `install.sh`, `cli.sh`, `example/`
- Do NOT break biome lint or format rules
- Do NOT add new dependencies

## Constraints

- `bun run lint:fix` must pass (biome format + lint)
- `bun run start` must still generate README correctly
- No breaking changes to existing keybindings (only add new ones or improve prompts)
- All new keybindings must follow the existing `space a {letter}` convention for AI actions
- All JSON files must stay valid JSONC

## Reference: sidekick.nvim Prompt Library

Sidekick ships these prompts (we should aim to cover them all):

| Sidekick Prompt             | Keymap    | Our Status                               |
| --------------------------- | --------- | ---------------------------------------- |
| explain                     | space a e | ✅ done                                  |
| fix                         | space a f | ✅ done                                  |
| tests                       | space a t | ✅ done                                  |
| refactor                    | space a r | ✅ done                                  |
| review                      | space a R | ✅ done                                  |
| document (doc comments)     | space a d | ✅ done                                  |
| document (thorough)         | space a D | ✅ done                                  |
| suggest names               | space a s | ✅ done                                  |
| explain LSP diagnostic      | space a l | ✅ done                                  |
| **optimize**                | space a o | ❌ missing                               |
| **changes**                 | space a c | ❌ missing (conflicts with toggle focus) |
| **diagnostics fix**         | —         | ❌ missing                               |
| **inline assist (generic)** | space a i | ✅ done                                  |

Target: Add optimize, diagnostics fix, and any other useful prompts sidekick offers.

## What's Been Tried

(Nothing yet — first session)
