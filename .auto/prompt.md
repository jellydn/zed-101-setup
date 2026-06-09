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

## Sidekick Prompt Coverage (ALL COVERED)

| Sidekick Prompt         | Our Keymap  | Status  |
| ----------------------- | ----------- | ------- |
| explain                 | space a e   | ✅ done |
| fix                     | space a f   | ✅ done |
| tests                   | space a t   | ✅ done |
| refactor                | space a r   | ✅ done |
| review                  | space a R   | ✅ done |
| document (doc comments) | space a d   | ✅ done |
| document (thorough)     | space a D   | ✅ done |
| suggest names           | space a s/n | ✅ done |
| explain LSP diagnostic  | space a l   | ✅ done |
| optimize                | space a o   | ✅ done |
| changes/review changes  | space a C   | ✅ done |
| fix diagnostics         | space a x   | ✅ done |
| security review         | space a S   | ✅ done |
| convert/transform       | space a v   | ✅ done |
| simplify                | space a m   | ✅ done |
| generate/scaffold       | space a g   | ✅ done |
| explain concept/API     | space a h   | ✅ done |
| explain behavior/flow   | space a b   | ✅ done |
| add types/schemas       | space a j   | ✅ done |
| summarize               | space a k   | ✅ done |
| debug                   | space a q   | ✅ done |

## Agent Panel Bindings (14 total)

| Keymap    | Action                             | Purpose                  |
| --------- | ---------------------------------- | ------------------------ |
| space a c | agent::ToggleFocus                 | Toggle agent panel focus |
| space a n | agent::NewThread                   | New agent thread         |
| space a p | agent::ToggleProfileSelector       | Switch profiles          |
| space a / | agent::ToggleModelSelector         | Switch models            |
| space a u | agent::OpenSettings                | Agent settings           |
| space a T | agent::NewTerminalThread           | Terminal in agent panel  |
| space a O | agent::ToggleOptionsMenu           | Options menu             |
| space a H | agent::ReviewBranchDiff            | Review branch diff       |
| space a M | agent::CycleFavoriteModels         | Cycle favorite models    |
| space a F | agent::ToggleFastMode              | Toggle fast mode         |
| space a A | agent::Toggle                      | Toggle agent panel       |
| space a > | agent::OpenAgentDiff               | Open agent diff          |
| space a N | agent::ToggleNewThreadMenu         | New thread menu          |
| space a K | agent::ToggleThinkingMode          | Toggle thinking mode     |
| space a + | inline_assistant::ThumbsUpResult   | Rate assist 👍           |
| space a - | inline_assistant::ThumbsDownResult | Rate assist 👎           |

## What's Been Tried

- **Iteration 1**: Added optimize, changes review, fix diagnostics, security review prompts. 17→25 bindings (+47%).
- **Iteration 2**: Added convert, simplify prompts + agent bindings (NewTerminalThread, ToggleOptionsMenu). 25→29 (+71%).
- **Iteration 3**: Added generate/scaffold, explain concept prompts + agent ReviewBranchDiff. 29→33 (+94%).
- **Iteration 4**: Added CycleFavoriteModels, ToggleFastMode, Toggle, OpenAgentDiff + behavior/flow, type annotations prompts. 33→37 (+118%).
- **Iteration 5**: Added summarize, debug prompts + ToggleNewThreadMenu, ToggleThinkingMode. 37→41 (+141%).
- **Settings**: Added notify_when_agent_waiting, single_file_review, agent_follow to agent settings.
- **Result**: 41 AI inline assist bindings (+141%), 14 agent panel bindings (+180%). All sidekick prompt categories covered.
