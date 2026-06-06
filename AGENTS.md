# AGENTS.md

## Repo overview

This repo is a **Zed Editor configuration bundle** — `settings.json`, `keymap.json`, `tasks.json` are the source files. `README.md` embeds them inside comment markers. `cli.ts` reads the source files and rewrites the README.

## Developer commands

```bash
bun run lint          # biome check .
bun run lint:fix      # biome check --write .
bun run typecheck     # tsc --noEmit
bun run start         # bun run cli.ts  (regenerates README.md)
bun run dev           # bun run --hot cli.ts  (hot-reload)
```

To install configs into your live Zed setup:

```bash
sh install.sh         # backs up ~/.config/zed/, copies repo files there
```

## README generation

`cli.ts` replaces `<!-- ALL-SETTINGS:START/END -->`, `<!-- ALL-KEYMAPS:START/END -->`, and `<!-- ALL-TASKS:START/END -->` markers in `README.md` with the current content of `settings.json`, `keymap.json`, and `tasks.json`. After writing, it runs `prettier --write` on `README.md` (falls back to `npx prettier`, warns if neither is available).

To regenerate from your live Zed config:

```bash
sh cli.sh             # copies from ~/.config/zed/, then runs bun run start
```

**Do not manually edit README sections** between the comment markers — they are overwritten by `cli.ts`. Edit `settings.json`, `keymap.json`, or `tasks.json` directly instead.

## JSONC caveat

`settings.json` and `keymap.json` are **JSONC** (JSON with Comments), not valid JSON. Biome handles them (`json.parser.allowComments: true`), but standard JSON linters will choke. They are listed in `.gitignore` for this reason, yet still tracked in git — don't be confused by the gitignore entry.

## Pre-commit & CI

- Prettier handles `html`, `css`, `markdown` files.
- Biome handles everything else (format, imports, lint, safe fixes).
- CI (`.github/workflows/pre-commit.yml`) runs pre-commit on PRs and pushes to `main`, then **auto-commits** any formatting fixes via `stefanzweifel/git-auto-commit-action@v7`.

## Style notes

- TypeScript: strict mode, `verbatimModuleSyntax`, `noEmit`, ESNext target/module.
- Bun runtime — lockfile is `bun.lockb`.
- Biome is the linter/formatter; ESLint is only in `example/`.
- Renovate automerges non-major deps and pins all except peer dependencies.
