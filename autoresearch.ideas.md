# Deferred Ideas

Ideas from the tiny-nvim migration that weren't pursued because they lack clear Zed equivalents or have diminishing returns.

## Keymaps (no clear Zed equivalent)

- **Tab management** — nvim `<leader><tab>l/o/f/tab/]/d/[` for tab operations. Zed tabs work differently.
- **Toggle autoformat** — nvim `<leader>uf`. Zed has no format-on-save toggle keybinding.
- **Inspect position** — nvim `<leader>ui` (`vim.show_pos`). Zed has `editor::OpenSyntaxTreeView` but no direct equivalent.
- **Inspect tree** — nvim `<leader>uI` (`:InspectTree`). Same as above.
- **Hover documentation** — nvim `K` for keywordprg. Zed shows hover on mouse hover; no dedicated keybinding.
- **Buffer close left/right** — nvim `<leader>bl` / `<leader>br`. No Zed equivalent for closing buffers by position.
- **Quickfix/location list** — nvim `[q`/`]q`, `<leader>xl`/`<leader>xq`. Zed uses diagnostics panel instead.

## Settings (already covered by defaults)

- **`splitbelow`/`splitright`** — Controlled by keybinding actions (SplitDown/SplitRight) in Zed.
- **`undofile`/`undolevels`** — Default in Zed.
- **`mouse` settings** — Not applicable in a GUI editor.
- **`ignorecase`/`smartcase`** — Already vim mode defaults.
- **`cursorline`** — Already on by default in Zed.
- **`list`/`listchars`** — Covered by `"show_whitespaces": "all"`.

## Language configs (lower priority)

- **YAML/TOML/CSS** language configs — Could add but Zed's defaults are reasonable.
- **HTML** language config — Same as above.
- **More LSP server overrides** — Could add explicit `language_servers` for more languages.

## Tasks (project-specific)

- **Run nearest test** — Task for `bun test` would be project-specific.
- **Build** — Depends on project setup.
