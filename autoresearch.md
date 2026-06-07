# Autoresearch: Code Companion–style AI keymaps

## Objective

Expand `keymap.json` with a `space a` prefix map analogous to Neovim Code Companion (`<leader>a` + letter), using Zed agent panel and inline assistant actions with prefilled prompts where appropriate.

## Metrics

- **Primary**: `companion_score` (unitless, **higher** is better) — weighted checklist of expected bindings and prompt-backed inline assists
- **Secondary**: `ai_bindings` — count of `space a …` bindings in `keymap.json`

## How to Run

`./autoresearch.sh` — outputs `METRIC companion_score=N` and `METRIC ai_bindings=N`.

## Files in Scope

- `keymap.json` — source keymap (JSONC)
- `README.md` — regenerated via `bun run start` after keymap changes
- `autoresearch.sh`, `autoresearch.md`, `autoresearch.ideas.md`, `autoresearch.checks.sh`

## Off Limits

- `settings.json`, `tasks.json`, `install.sh`, CI workflows (unless required for checks)

## Constraints

- Preserve existing `space a c` → `agent::ToggleFocus`
- Do not steal `space e` (project reveal) or other established `space` prefixes
- Use Zed action names from official docs (`assistant::InlineAssist`, `agent::*`)
- Run `bun run lint` and `bun run typecheck` via checks script after successful benchmark

## What's Been Tried

- **Win (score 33/33)**: `space a` prefix — `c`/`v` toggle agent; `a` open add-context menu; `m`/`l` inline assist (commit, LSP); visual-only `e f t d D r R n` with Code Companion–aligned prompts via `assistant::InlineAssist`.
- Checklist also scores `space a s` → `agent::AddSelectionToThread` (max score 35).
- **Win (40/40)**: `space a S` → `action::Sequence` `[AddSelectionToThread, ToggleFocus]`; `space a g` → `agent::OpenRulesLibrary`.
- **Win (44/44)**: `space a N` → `agent::NewThread`; `space a o` → `agent::OpenAgentDiff`.
- **Win (49/49)**: `space a b` → `git::ReviewDiff`; `space a i` → `assistant::InlineAssist` (no prefilled prompt).
- **Win (56)**: `space a p` profiles, `space a h` send review to agent, `space a G` global AGENTS.md; checklist includes `space a c`.
- Fixed unrelated `biome` format on `.claude/settings.local.json` so checks pass.
