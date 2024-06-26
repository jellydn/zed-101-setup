<h1 align="center">Welcome to zed-101-setup 👋</h1>
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
```

## Vim mode

For detailed Vim mode setup instructions, refer to the [Zed Vim Mode Documentation](https://zed.dev/docs/vim).

[![Vim mode](https://i.gyazo.com/a7d4d6585d4b997153542c3b4f42bf61.gif)](https://gyazo.com/a7d4d6585d4b997153542c3b4f42bf61)

### Settings

Update your settings.json file with the following configuration:

<!-- ALL-SETTINGS:START -->

```json
// settings.json, generated at Mon Jul 01 2024 22:44:11 GMT+0800 (Singapore Standard Time)
// Zed settings
//
// For information on how to configure Zed, see the Zed
// documentation: https://zed.dev/docs/configuring-zed
//
// To see all of Zed's default settings without changing your
// custom settings, run the `open default settings` command
// from the command palette or from `Zed` application menu.
{
  "theme": "Dracula",
  "ui_font_size": 16,
  "buffer_font_size": 18,
  "buffer_font_family": "JetBrainsMono Nerd Font",
  // Vim mode settings
  "vim_mode": true,
  // use relative line numbers
  "relative_line_numbers": true,
  "tab_bar": {
    "show": true
  },
  "scrollbar": {
    "show": "never"
  },
  // Local AI with Ollama, refer https://zed.dev/docs/assistant-panel#using-ollama-on-macos
  "assistant": {
    "version": "1",
    "provider": {
      "name": "openai",
      "type": "openai",
      "default_model": "gpt-4-turbo-preview",
      "api_url": "http://localhost:11434/v1"
    }
  },
  "languages": {
    "TypeScript": {
      // Refer https://github.com/jellydn/ts-inlay-hints for how to setup for Neovim and VSCode
      "inlay_hints": {
        "enabled": true,
        "show_parameter_hints": false,
        "show_other_hints": true,
        "show_type_hints": true
      }
    }
  },
  // Use zed commit editor
  "terminal": {
    "env": {
      "EDITOR": "zed --wait"
    }
  },
  // Dockerfile syntax highlighting
  "file_types": {
    "Dockerfile": ["Dockerfile", "Dockerfile.*"]
  }
}
```

<!-- ALL-SETTINGS:END -->

[![Demo](https://i.gyazo.com/28f24b1bd9f0f49658862ca406104c75.png)](https://gyazo.com/28f24b1bd9f0f49658862ca406104c75)

[![Demo 2](https://i.gyazo.com/00cc139a589d39c0fd6ee0aa21c1a051.png)](https://gyazo.com/00cc139a589d39c0fd6ee0aa21c1a051)

## Keymaps

Update your keymap.json file with the following key bindings:

<!-- ALL-KEYMAPS:START -->

```json
// keymap.json, generated at Mon Jul 01 2024 22:44:11 GMT+0800 (Singapore Standard Time)
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

      // Open markdown preview
      "space m p": "markdown::OpenPreview",
      "space m P": "markdown::OpenPreviewToTheSide"
    }
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
      // LSP
      "g d": "editor::GoToDefinition",
      "g D": "editor::GoToDefinitionSplit",
      "g i": "editor::GoToImplementation",
      "g I": "editor::GoToImplementationSplit",
      "g t": "editor::GoToTypeDefinition",
      "g T": "editor::GoToTypeDefinitionSplit",
      "g r": "editor::FindAllReferences",
      "] d": "editor::GoToDiagnostic",
      "[ d": "editor::GoToPrevDiagnostic",
      // Git prev/next hunk
      "] h": "editor::GoToHunk",
      "[ h": "editor::GoToPrevHunk",
      // Symbol search
      "s s": "outline::Toggle",
      "s S": "project_symbols::Toggle",
      // Project diagnostic
      "space x x": "diagnostics::Deploy",
      // Switch between buffers
      "shift-h": "pane::ActivatePrevItem",
      "shift-l": "pane::ActivateNextItem",
      // Close active panel
      "shift-q": "pane::CloseActiveItem",
      // Save file
      "ctrl-s": "workspace::Save",
      // File finder
      "space space": "file_finder::Toggle"
    }
  },
  // Comment code
  {
    "context": "Editor && vim_mode == visual && !VimWaiting && !menu",
    "bindings": {
      // visual, visual line & visual block modes
      "g c": "editor::ToggleComments"
    }
  },
  {
    "context": "Editor && vim_mode == insert && !menu",
    "bindings": {
      // put key-bindings here if you want them to work in insert mode
      "j j": "vim::NormalBefore" // remap jj in insert mode to escape
    }
  },
  // Rename
  {
    "context": "Editor && vim_operator == c",
    "bindings": {
      "c": "vim::CurrentLine",
      "r": "editor::Rename" // zed specific
    }
  },
  // Code Action
  {
    "context": "Editor && vim_operator == c",
    "bindings": {
      "c": "vim::CurrentLine",
      "a": "editor::ToggleCodeActions" // zed specific
    }
  },
  // Toggle terminal
  {
    "context": "Workspace",
    "bindings": {
      // Toggle terminal
      "ctrl-\\": "terminal_panel::ToggleFocus"
    }
  },
  {
    "context": "Terminal",
    "bindings": {}
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
      "p": "project_panel::Paste"
    }
  }
]
```

<!-- ALL-KEYMAPS:END -->

## Setup local AI with Ollama

Refer to the [Ollama](https://ollama.ai) Setup Guide for detailed [instructions](https://zed.dev/docs/assistant-panel#using-ollama-on-macos).

## Resources

- [Text Manipulation Kung Fu for the Aspiring Black Belt](https://zed.dev/blog/text-manipulation)
- [Vim - Zed](https://zed.dev/docs/vim)
- [JavaScript - Zed](https://zed.dev/docs/languages/javascript)
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
