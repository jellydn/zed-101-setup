# AGENTS.md

## Repo overview

This repo is a **Zed Editor configuration bundle** — `settings.json`, `keymap.json`, `tasks.json` are the source files. `README.md` embeds them inside comment markers. `cli.ts` reads the source files and rewrites the README.

## Developer commands

```
bun run lint          # biome check .
bun run lint:fix      # biome check --write .
bun run typecheck     # tsc --noEmit
bun run start         # bun run cli.ts  (regenerates README.md)
bun run dev           # bun run --hot cli.ts  (hot-reload)
```

## README generation

`cli.ts` replaces `<!-- ALL-SETTINGS:START/END -->`, `<!-- ALL-KEYMAPS:START/END -->`, and `<!-- ALL-TASKS:START/END -->` markers in `README.md` with the current content of `settings.json`, `keymap.json`, and `tasks.json`. After writing, it runs `prettier --write` on `README.md` (falls back to `npx prettier`, warns if neither is available).

To regenerate from your live Zed config:

```bash
sh cli.sh
```

This copies `settings.json` and `keymap.json` from `~/.config/zed/`, then runs `bun run start`.

## Pre-commit

- Prettier handles `html`, `css`, `markdown` files.
- Biome handles everything else (format, imports, lint, safe fixes).

## Style notes

- TypeScript: strict mode, `verbatimModuleSyntax`, `noEmit`, ESNext target/module.
- Bun runtime — lockfile is `bun.lockb`.
- Biome is the linter/formatter; ESLint is only in `example/`.
- Renovate automerges non-major deps and pins all except peer dependencies.
