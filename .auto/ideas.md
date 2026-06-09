# Deferred Ideas

- **Tool-specific keybinding contexts**: Like sidekick's per-tool keymaps (claude vs gemini vs copilot), we could bind `space a` + letter to open specific external agents directly.
- **Context-aware prompt templates**: Sidekick uses `{file}`, `{selection}`, `{diagnostics}` variables. Zed's InlineAssist already supports this natively — the prompt strings use natural language that gets enriched by context. This is already optimal.
- **Dashboard/statusline integration**: Sidekick shows AI status in Neovim's statusline. Zed could use `agent.status` or similar (not currently exposed via settings).
- **Prettier format integration**: The README generation step (`bun run start`) runs prettier on README.md. Consider integrating prettier into the format workflow.

## Completed

- ~~**Custom agent profiles**: Implemented in experiment #28. Added 3 profiles (write/review/debug) with differentiated tool permissions, auto-allow/deny terminal patterns, fetch URL whitelisting, and sandbox permissions.~~
