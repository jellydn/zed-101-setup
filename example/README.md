# zed-bun-example

To install dependencies:

```bash
bun install
```

To run:

```bash
bun run index.ts
```

This project was created using `bun init` in bun v1.1.10. [Bun](https://bun.sh) is a fast all-in-one JavaScript runtime.

## LSP Testing Examples

These files exercise the LSP configurations in `settings.json`:

| File                                                       | LSP Server    | Test your setup by opening the file and checking…                                                           |
| ---------------------------------------------------------- | ------------- | ----------------------------------------------------------------------------------------------------------- |
| [`rust.rs`](./rust.rs)                                     | rust-analyzer | Inlay hints, clippy diagnostics, derive expansion                                                           |
| [`go.go`](./go.go)                                         | gopls         | Gofumpt formatting, staticcheck, analyses (nilness, fieldalignment, unusedparams, unusedwrite), inlay hints |
| [`ts-lsp.ts`](./ts-lsp.ts)                                 | vtsls         | Inlay hints (param, type, return, property), auto imports, organize imports                                 |
| [`biome.js`](./biome.js)                                   | biome         | Formatter (quotes, semicolons, trailing commas), linter (no-unused, use-const), organize imports            |
| [`biome-config-example.json`](./biome-config-example.json) | biome         | Mirrors the `lsp.biome.settings` from the parent settings.json — validates against Biome 2.4.x              |
| [`biome.css`](./biome.css)                                 | biome         | CSS formatter (indentation, nesting, color functions, keyframes)                                            |

Uncomment the corresponding `lsp` block in `settings.json` to enable each LSP before testing.
