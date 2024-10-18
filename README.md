<h1 align="center">Welcome to zed-101-setup 👋</h1>

<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->

[![All Contributors](https://img.shields.io/badge/all_contributors-4-orange.svg?style=flat-square)](#contributors-)

<!-- ALL-CONTRIBUTORS-BADGE:END -->
<p>
  Your ultimate guide to setting up Zed Editor with Vim mode, tailored settings, and key bindings for a seamless coding experience
</p>

[![IT Man -  Zed Editor 101 - Ultimate Zed Editor Setup Guide](https://i.ytimg.com/vi/NAk4tyfIM3A/hqdefault.jpg)](https://www.youtube.com/watch?v=NAk4tyfIM3A)

## Introduction

The Zed Editor 101 setup guide is designed to help you configure Zed Editor to enhance your development workflow. Whether you’re a Vim enthusiast or looking to boost your productivity with custom settings and key bindings, this guide provides all the necessary steps and resources. Follow along to get your Zed Editor configured with Nerd Font, Vim mode, local AI assistance, and more.

## Nerd Font

Install Nerd Font using the following command:

```sh
curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh | bash
getnf
```

## Vim mode

For detailed Vim mode setup instructions, refer to the [Zed Vim Mode Documentation](https://zed.dev/docs/vim).

[![Vim mode](https://i.gyazo.com/a7d4d6585d4b997153542c3b4f42bf61.gif)](https://gyazo.com/a7d4d6585d4b997153542c3b4f42bf61)

### Settings

Update your settings.json file with the following configuration:

<!-- ALL-SETTINGS:START -->

```jsonc
// settings.json, generated at Sun Oct 06 2024 07:32:28 GMT+0800 (Singapore Standard Time)
// Zed settings
//
// For information on how to configure Zed, see the Zed
// documentation: https://zed.dev/docs/configuring-zed
//
// To see all of Zed's default settings without changing your
// custom settings, run the `open default settings` command
// from the command palette or from `Zed` application menu.
{
  "base_keymap": "VSCode",
  "theme": "Dracula",
  "ui_font_size": 16,
  "buffer_font_size": 18,
  // NOTE: Change the font family to your preference
  "buffer_font_family": "GeistMono Nerd Font",
  // Vim mode settings
  "vim_mode": true,
  // use relative line numbers
  "relative_line_numbers": true,
  "tab_bar": {
    "show": true,
  },
  "scrollbar": {
    "show": "never",
  },
  // Indentation, rainbow indentation
  "indent_guides": {
    "enabled": true,
    "coloring": "indent_aware",
  },
  // NOTE: Zen mode, refer https://github.com/zed-industries/zed/issues/4382 when it's resolved
  "centered_layout": {
    "left_padding": 0.15,
    "right_padding": 0.15,
  },
  // Use Copilot Chat AI as default
  "assistant": {
    "default_model": {
      "provider": "copilot_chat",
      "model": "gpt-4o",
    },
    "version": "2",
  },
  // Uncomment below to use local AI with Ollama, refer https://zed.dev/docs/language-model-integration?highlight=ollama#using-ollama-on-macos
  // "assistant": {
  //   "default_model": {
  //     "provider": "ollama",
  //     "model": "llama3.1:latest"
  //   },
  //   "version": "2",
  //   "provider": null
  // },
  "language_models": {
    "ollama": {
      "api_url": "http://localhost:11434",
    },
  },
  // Inlay hints preconfigured by Zed: Go, Rust, Typescript and Svelte
  "inlay_hints": {
    "enabled": true,
  },
  // LSP
  "lsp": {
    "tailwindcss-language-server": {
      "settings": {
        "classAttributes": ["class", "className", "ngClass", "styles"],
      },
    },
  },
  "languages": {
    // Refer https://zed.dev/docs/languages/javascript and https://zed.dev/docs/languages/typescript for more info
    "TypeScript": {
      // Refer https://github.com/jellydn/ts-inlay-hints for how to setup for Neovim and VSCode
      "inlay_hints": {
        "enabled": true,
        "show_parameter_hints": false,
        "show_other_hints": true,
        "show_type_hints": true,
      },
    },
    "Python": {
      "format_on_save": { "language_server": { "name": "ruff" } },
      "formatter": { "language_server": { "name": "ruff" } },
      "language_servers": ["pyright", "ruff"],
    },
  },
  // Use zed commit editor
  "terminal": {
    "env": {
      "EDITOR": "zed --wait",
    },
  },
  // File syntax highlighting
  "file_types": {
    "Dockerfile": ["Dockerfile", "Dockerfile.*"],
    "JSON": ["json", "jsonc", "*.code-snippets"],
  },
  // File scan exclusions, hide on the file explorer and search
  "file_scan_exclusions": [
    "**/.git",
    "**/.svn",
    "**/.hg",
    "**/CVS",
    "**/.DS_Store",
    "**/Thumbs.db",
    "**/.classpath",
    "**/.settings",
    // above is default from Zed
    "**/out",
    "**/dist",
    "**/.husky",
    "**/.turbo",
    "**/.vscode-test",
    "**/.vscode",
    "**/.next",
    "**/.storybook",
    "**/node_modules",
  ],
  // Turn off telemetry
  "telemetry": {
    "diagnostics": false,
    "metrics": false,
  },
  // Move all panel to the right
  "project_panel": {
    "button": true,
    "dock": "right",
    "git_status": true,
  },
  "outline_panel": {
    "dock": "right",
  },
  "collaboration_panel": {
    "dock": "left",
  },
  // Move some unnecessary panels to the left
  "notification_panel": {
    "dock": "left",
  },
  "chat_panel": {
    "dock": "left",
  },
}
```

<!-- ALL-SETTINGS:END -->

[![Demo](https://i.gyazo.com/28f24b1bd9f0f49658862ca406104c75.png)](https://gyazo.com/28f24b1bd9f0f49658862ca406104c75)

[![Demo 2](https://i.gyazo.com/00cc139a589d39c0fd6ee0aa21c1a051.png)](https://gyazo.com/00cc139a589d39c0fd6ee0aa21c1a051)

## Keymaps

Update your keymap.json file with the following key bindings:

<!-- ALL-KEYMAPS:START -->

```jsonc
// keymap.json, generated at Sun Oct 06 2024 07:32:28 GMT+0800 (Singapore Standard Time)
[
  {
    "context": "Editor && (vim_mode == normal || vim_mode == visual) && !VimWaiting && !menu",
    "bindings": {
      // put key-bindings here if you want them to work in normal & visual mode
      // Git
      "space g h d": "editor::ToggleHunkDiff",
      "space g h r": "editor::RevertSelectedHunks",

      // Toggle inlay hints
      "space t i": "editor::ToggleInlayHints",

      // Toggle soft wrap
      "space u w": "editor::ToggleSoftWrap",

      // NOTE: Toggle Zen mode, not fully working yet
      "space c z": "workspace::ToggleCenteredLayout",

      // Open markdown preview
      "space m p": "markdown::OpenPreview",
      "space m P": "markdown::OpenPreviewToTheSide",

      // Open recent project
      "space f p": "projects::OpenRecent",
      // Search word under cursor
      "space s w": "pane::DeploySearch",

      // Chat with AI
      "space a c": "assistant::ToggleFocus",
      // Go to file with `gf`
      "g f": "editor::OpenExcerpts",
    },
  },
  {
    "context": "Editor && vim_mode == normal && !VimWaiting && !menu",
    "bindings": {
      // put key-bindings here if you want them to work only in normal mode
      // Window movement bindings
      // Ctrl jklk to move between panes
      "ctrl-h": ["workspace::ActivatePaneInDirection", "Left"],
      "ctrl-l": ["workspace::ActivatePaneInDirection", "Right"],
      "ctrl-k": ["workspace::ActivatePaneInDirection", "Up"],
      "ctrl-j": ["workspace::ActivatePaneInDirection", "Down"],

      // +LSP
      "space c a": "editor::ToggleCodeActions",
      "space .": "editor::ToggleCodeActions",
      "space c r": "editor::Rename",
      "g d": "editor::GoToDefinition",
      "g D": "editor::GoToDefinitionSplit",
      "g i": "editor::GoToImplementation",
      "g I": "editor::GoToImplementationSplit",
      "g t": "editor::GoToTypeDefinition",
      "g T": "editor::GoToTypeDefinitionSplit",
      "g r": "editor::FindAllReferences",
      "] d": "editor::GoToDiagnostic",
      "[ d": "editor::GoToPrevDiagnostic",
      // TODO: Go to next/prev error
      "] e": "editor::GoToDiagnostic",
      "[ e": "editor::GoToPrevDiagnostic",
      // Symbol search
      "s s": "outline::Toggle",
      "s S": "project_symbols::Toggle",
      // Diagnostic
      "space x x": "diagnostics::Deploy",

      // +Git
      // Git prev/next hunk
      "] h": "editor::GoToHunk",
      "[ h": "editor::GoToPrevHunk",

      // TODO: git diff is not ready yet, refer https://github.com/zed-industries/zed/issues/8665#issuecomment-2194000497

      // + Buffers
      // Switch between buffers
      "shift-h": "pane::ActivatePrevItem",
      "shift-l": "pane::ActivateNextItem",
      // Close active panel
      "shift-q": "pane::CloseActiveItem",
      "ctrl-q": "pane::CloseActiveItem",
      "space b d": "pane::CloseActiveItem",
      // Close other items
      "space b o": "pane::CloseInactiveItems",
      // Save file
      "ctrl-s": "workspace::Save",
      // File finder
      "space space": "file_finder::Toggle",
      // Project search
      "space /": "pane::DeploySearch",
      // TODO: Open other files
      // Show project panel with current file
      "space e": "pane::RevealInProjectPanel",
    },
  },
  // Empty pane, set of keybindings that are available when there is no active editor
  {
    "context": "EmptyPane || SharedScreen",
    "bindings": {
      // Open file finder
      "space space": "file_finder::Toggle",
      // Open recent project
      "space f p": "projects::OpenRecent",
    },
  },
  // Comment code
  {
    "context": "Editor && vim_mode == visual && !VimWaiting && !menu",
    "bindings": {
      // visual, visual line & visual block modes
      "g c": "editor::ToggleComments",
    },
  },
  // Better escape
  {
    "context": "Editor && vim_mode == insert && !menu",
    "bindings": {
      "j j": "vim::NormalBefore", // remap jj in insert mode to escape
      "j k": "vim::NormalBefore", // remap jk in insert mode to escape
    },
  },
  // Rename
  {
    "context": "Editor && vim_operator == c",
    "bindings": {
      "c": "vim::CurrentLine",
      "r": "editor::Rename", // zed specific
    },
  },
  // Code Action
  {
    "context": "Editor && vim_operator == c",
    "bindings": {
      "c": "vim::CurrentLine",
      "a": "editor::ToggleCodeActions", // zed specific
    },
  },
  // Toggle terminal
  {
    "context": "Workspace",
    "bindings": {
      "ctrl-\\": "terminal_panel::ToggleFocus",
    },
  },
  {
    "context": "Terminal",
    "bindings": {
      "ctrl-h": ["workspace::ActivatePaneInDirection", "Left"],
      "ctrl-l": ["workspace::ActivatePaneInDirection", "Right"],
      "ctrl-k": ["workspace::ActivatePaneInDirection", "Up"],
      "ctrl-j": ["workspace::ActivatePaneInDirection", "Down"],
    },
  },
  // File panel (netrw)
  {
    "context": "ProjectPanel && not_editing",
    "bindings": {
      "a": "project_panel::NewFile",
      "A": "project_panel::NewDirectory",
      "r": "project_panel::Rename",
      "d": "project_panel::Delete",
      "x": "project_panel::Cut",
      "c": "project_panel::Copy",
      "p": "project_panel::Paste",
      // Close project panel as project file panel on the right
      "q": "workspace::ToggleRightDock",
      "space e": "workspace::ToggleRightDock",
      // Navigate between panel
      "ctrl-h": ["workspace::ActivatePaneInDirection", "Left"],
      "ctrl-l": ["workspace::ActivatePaneInDirection", "Right"],
      "ctrl-k": ["workspace::ActivatePaneInDirection", "Up"],
      "ctrl-j": ["workspace::ActivatePaneInDirection", "Down"],
    },
  },
  // Panel nagivation
  {
    "context": "Dock",
    "bindings": {
      "ctrl-w h": ["workspace::ActivatePaneInDirection", "Left"],
      "ctrl-w l": ["workspace::ActivatePaneInDirection", "Right"],
      "ctrl-w k": ["workspace::ActivatePaneInDirection", "Up"],
      "ctrl-w j": ["workspace::ActivatePaneInDirection", "Down"],
    },
  },
  {
    "context": "Workspace",
    "bindings": {
      // Map VSCode like keybindings
      "cmd-b": "workspace::ToggleRightDock",
    },
  },
  // Subword motion is not working really nice with `ciw`, disable for now
  // {
  //   "context": "VimControl && !menu",
  //   "bindings": {
  //     "w": "vim::NextSubwordStart",
  //     "b": "vim::PreviousSubwordStart",
  //     "e": "vim::NextSubwordEnd",
  //     "g e": "vim::PreviousSubwordEnd"
  //   }
  // }
]
```

<!-- ALL-KEYMAPS:END -->

## Setup local AI with Ollama

Refer to the [Ollama](https://ollama.ai) Setup Guide for detailed [instructions](https://zed.dev/docs/language-model-integration?highlight=ollama#using-ollama-on-macos).

## Recommend extensions

- [biomejs/biome-zed: Biome extension for Zed](https://github.com/biomejs/biome-zed)
- [oxc-project/zed-oxc: Oxc extension for Zed](https://github.com/oxc-project/zed-oxc)
- [zed-industries/zed: Ruff](https://github.com/zed-industries/zed/blob/main/extensions/ruff/extension.toml)

## Resources

- [Text Manipulation Kung Fu for the Aspiring Black Belt](https://zed.dev/blog/text-manipulation)
- [Vim - Zed](https://zed.dev/docs/vim)
- [JavaScript - Zed](https://zed.dev/docs/languages/javascript)
- [Bringing Interactive Computing to Zed: Introducing REPL Support](https://zed.dev/blog/repl)
- [Leaving Neovim for Zed • Steve Simkins](https://stevedylan.dev/posts/leaving-neovim-for-zed)
- [Other Zed config](https://gist.github.com/search?l=JSON&o=desc&q=Zed+config&s=)

## How to generate the settings

```bash
cp ~/.config/zed/settings.json settings.json
cp ~/.config/zed/keymap.json keymap.json
bun run cli.ts
```

## Author

👤 **Huynh Duc Dung**

- Website: https://productsway.com/
- Twitter: [@jellydn](https://twitter.com/jellydn)
- Github: [@jellydn](https://github.com/jellydn)

## Show your support

If this guide has been helpful, please give it a ⭐️.

[![kofi](https://img.shields.io/badge/Ko--fi-F16061?style=for-the-badge&logo=ko-fi&logoColor=white)](https://ko-fi.com/dunghd)
[![paypal](https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white)](https://paypal.me/dunghd)
[![buymeacoffee](https://img.shields.io/badge/Buy_Me_A_Coffee-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://www.buymeacoffee.com/dunghd)

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://productsway.com/"><img src="https://avatars.githubusercontent.com/u/870029?v=4?s=100" width="100px;" alt="Dung Duc Huynh (Kaka)"/><br /><sub><b>Dung Duc Huynh (Kaka)</b></sub></a><br /><a href="https://github.com/jellydn/zed-101-setup/commits?author=jellydn" title="Code">💻</a> <a href="https://github.com/jellydn/zed-101-setup/commits?author=jellydn" title="Documentation">📖</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/d1y"><img src="https://avatars.githubusercontent.com/u/45585937?v=4?s=100" width="100px;" alt="d1y"/><br /><sub><b>d1y</b></sub></a><br /><a href="https://github.com/jellydn/zed-101-setup/commits?author=d1y" title="Documentation">📖</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://nadiyar.com"><img src="https://avatars.githubusercontent.com/u/106643149?v=4?s=100" width="100px;" alt="Naadiyaar"/><br /><sub><b>Naadiyaar</b></sub></a><br /><a href="https://github.com/jellydn/zed-101-setup/commits?author=Naadiyaar" title="Documentation">📖</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/JanLubojacky"><img src="https://avatars.githubusercontent.com/u/87865439?v=4?s=100" width="100px;" alt="Jan Lubojacký"/><br /><sub><b>Jan Lubojacký</b></sub></a><br /><a href="https://github.com/jellydn/zed-101-setup/commits?author=JanLubojacky" title="Documentation">📖</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
