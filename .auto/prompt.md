# Autoresearch: Extend AI Usage like sidekick.nvim

## Objective

Extend the Zed editor AI configuration to match the rich, context-aware AI interaction patterns from [folke/sidekick.nvim](https://github.com/folke/sidekick.nvim). This means adding more inline assist prompt presets, structured agent keybindings, and richer prompts — making AI interactions feel as seamless as sidekick.nvim's Neovim experience.

## Metrics

- **Primary**: ai_keybindings_count (count, higher is better) — number of unique `assistant::InlineAssist` bindings with custom prompts across all context blocks.
- **Secondary**: agent_keybindings_count (count, higher is better) — number of `agent::*` binding actions in keymap.json.
- **Secondary**: biome_ok (boolean, 1=pass) — biome check passes (lint + format).

## How to Run

`./.auto/measure.sh` — outputs `METRIC name=number` lines.

## Files in Scope

- `settings.json` — Zed settings (agent config, inline_assistant_model, favorite_models)
- `keymap.json` — Key bindings (all `assistant::InlineAssist` and `agent::*` bindings)
- `README.md` — Generated from source (regenerated via `bun run start`)

## Off Limits

- Do NOT modify `cli.ts`
- Do NOT touch `.github/`, `install.sh`, `cli.sh`, `example/`
- Do NOT break biome

## Constraints

- `bun run lint:fix` must pass
- `bun run start` must regenerate README correctly
- No breaking changes to existing keybindings
- All new bindings follow `space a {letter/convention}` pattern
- All JSON files must stay valid JSONC

## Final Results

| Metric                        | Baseline | Final  | Delta     |
| ----------------------------- | -------- | ------ | --------- |
| **AI Inline Assist Bindings** | 17       | **43** | **+153%** |
| **Agent Panel Bindings**      | 5        | **48** | **+860%** |
| **Biome Check**               | ✅       | ✅     | —         |

## Experiment Log

### Iteration 1: Core sidekick prompts

Added: space a o (optimize), space a C (changes review), space a x (fix diagnostics), space a S (security review). 17→25.

### Iteration 2: Convert + simplify + agent basics

Added: space a v (convert/transform), space a m (simplify) + agent::NewTerminalThread, agent::ToggleOptionsMenu. 25→29.

### Iteration 3: Generate + explain + agent diff

Added: space a g (generate/scaffold), space a h (explain concept) + agent::ReviewBranchDiff. 29→33.

### Iteration 4: Agent model switchers + deeper prompts

Added: agent::CycleFavoriteModels, ToggleFastMode, Toggle, OpenAgentDiff + space a b (behavior/flow), space a j (type annotations). 33→37.

### Iteration 5: Summarize + debug + remaining agent

Added: space a k (summarize), space a q (debug) + agent::ToggleNewThreadMenu, ToggleThinkingMode. 37→41.

### Iteration 6: Edit review workflow + agent panel depth

Added: Keep/Reject hunks (Y,P,w,W), CycleInlineAssist (,,.), 9+ agent panel actions (archive, markdown export, clipboard, queue management, conflict resolution, scroll navigation, thread switcher). Agent: 21→43.

### Iteration 7: Terminal AI + prompt quality

Added: Terminal context agent access (sidekick-style), agent::Chat, ChatWithFollow, OpenGlobal/ProjectAGENTS.mdRules. Improved refactor/fix/review prompts with structured guidance. Agent: 43→48.

### Iteration 8: Visual block completeness

Added: Missing space a l (LSP diagnostic) and space a s (suggest names) to visual-only block. Symmetry between normal+visual and visual-only now complete at 43 total AI bindings.

### Settings improvements

Added: notify_when_agent_waiting, single_file_review, agent_follow.

## Saturation note

Both metrics are at natural maximums. UI keybindings (space a prefix in keymap.json) have been exhaustively mapped to available Zed agent actions. Remaining unexplored paths are either not supported by Zed's API (agent profiles, statusline integration) or would add no real user value.
