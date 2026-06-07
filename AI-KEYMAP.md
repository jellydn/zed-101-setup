# `space a` — AI keymap (Code Companion style)

Leader: **`space`** then **`a`** then the key below.  
Source: `keymap.json` (sync with `bun run start` for README embed).

## Essentials

| Keys      | Action                           | Notes                              |
| --------- | -------------------------------- | ---------------------------------- |
| `c` / `v` | Toggle agent panel               | Same as Code Companion chat toggle |
| `a`       | Add context menu                 | Like Code Companion actions        |
| `s`       | Add selection to thread          |                                    |
| `S`       | Selection → thread + focus agent | Sequence; may race async           |
| `N`       | New agent thread                 |                                    |
| `i`       | Inline assist (blank prompt)     | Like `ctrl-enter`                  |
| `0`       | Edit prediction menu             | Automatic inline suggestions       |
| `1`       | Open skill creator               | Author / import agent skills       |

## Code Companion inline (visual selection)

| Keys      | Intent                |
| --------- | --------------------- |
| `e`       | Explain               |
| `f`       | Fix                   |
| `t`       | Tests                 |
| `d` / `D` | Inline doc / full doc |
| `r` / `R` | Refactor / review     |
| `n`       | Naming                |

## Same intents on cursor line (normal + visual)

| Keys      | Intent                |
| --------- | --------------------- |
| `E`       | Explain               |
| `F`       | Fix                   |
| `T`       | Tests                 |
| `J` / `L` | Inline doc / full doc |
| `O` / `Q` | Refactor / review     |
| `z`       | Naming                |

## Git & review

| Keys      | Action                               |
| --------- | ------------------------------------ |
| `m`       | Inline staged commit message         |
| `y`       | `git::GenerateCommitMessage`         |
| `b`       | `git::ReviewDiff`                    |
| `B`       | `agent::ReviewBranchDiff`            |
| `h`       | Send editor review comments to agent |
| `]` / `[` | Keep / reject hunk                   |
| `>` / `<` | Keep all / reject all                |
| `U`       | Undo last reject                     |

## Agent panel

| Keys      | Action                       |
| --------- | ---------------------------- |
| `/`       | Model selector               |
| `k`       | Profile selector             |
| `,`       | Thinking mode                |
| `-`       | Cycle favorite models        |
| `w`       | Follow agent in editor       |
| `g`       | Rules library                |
| `G` / `P` | Global / project `AGENTS.md` |

Full list: search `space a` in `keymap.json`.
