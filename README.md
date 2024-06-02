<h1 align="center">Welcome to zed-101-setup 👋</h1>
<p>
  Zed Editor 101 setup
</p>

## Nerd Font - https://github.com/getnf/getnf

```sh
curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh | bash
```

## Vim mode - https://zed.dev/docs/vim

### Settings

```json
// settings.json
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
    "show": false
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
      "inlay_hints": {
        "enabled": true
      }
    }
  }
}
```

## Keymaps

```json
// keymap.json
[
  {
    "context": "Editor && (vim_mode == normal || vim_mode == visual) && !VimWaiting && !menu",
    "bindings": {
      // put key-bindings here if you want them to work in normal & visual mode
      // Git
      "space g h d": "editor::ToggleHunkDiff",
      "space g h r": "editor::RevertSelectedHunks"
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
      // Symbol search
      "s s": "outline::Toggle",
      // Project diagnostic
      "space x x": "diagnostics::Deploy",
      // Switch between buffers
      "shift-h": "pane::ActivatePrevItem",
      "shift-l": "pane::ActivateNextItem",
      // Close active panel
      "shift-q": "pane::CloseActiveItem",
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

## Setup local AI with Ollama - https://zed.dev/docs/assistant-panel#using-ollama-on-macos

## Resources

- [Text Manipulation Kung Fu for the Aspiring Black Belt](https://zed.dev/blog/text-manipulation)
- [Vim - Zed](https://zed.dev/docs/vim)
- [JavaScript - Zed](https://zed.dev/docs/languages/javascript)

## TODO

- [ ] Generate keymap.json and settings.json using a script

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
