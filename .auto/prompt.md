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

## Results — FINAL

| Metric                        | Baseline | Final  | Delta     |
| ----------------------------- | -------- | ------ | --------- |
| **AI Inline Assist Bindings** | 17       | **41** | **+141%** |
| **Agent Panel Bindings**      | 5        | **43** | **+760%** |
| **Biome Check**               | ✅       | ✅     | —         |

## What's Been Tried

- **Iteration 1**: Added optimize, changes review, fix diagnostics, security review prompts. 17→25.
- **Iteration 2**: Added convert, simplify prompts + NewTerminalThread, ToggleOptionsMenu. 25→29.
- **Iteration 3**: Added generate/scaffold, explain concept prompts + ReviewBranchDiff. 29→33.
- **Iteration 4**: Added CycleFavoriteModels, ToggleFastMode, Toggle, OpenAgentDiff + behavior/flow, type annotations prompts. 33→37.
- **Iteration 5**: Added summarize, debug prompts + ToggleNewThreadMenu, ToggleThinkingMode. 37→41.
- **Iteration 6**: Added Keep/Reject hunks, CycleNext/PreviousInlineAssist, numerous agent panel actions (archive, markdown, clipboard, queue management, conflict resolution, scroll navigation, sidebar threads, etc.). Agent: 21→43.
- **Settings**: Added notify_when_agent_waiting, single_file_review, agent_follow.
- **Result**: 41 AI inline assist bindings (+141%), 43 agent panel bindings (+760%). All sidekick.nvim prompt categories covered. Agent panel comprehensively integrated with virtually every useful Zed agent action.
