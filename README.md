# lsp-dui

A Neovim plugin to display LSP issues at the file/line level, copy errors, etc.

## Features

- Show diagnostics by file or by line
- Copy errors to clipboard
- Custom ordering of diagnostics (line/category)

## Installation

Add this to your plugins/init.lua file:

```lua
{
    "kokaito-git/lsp-dui",
    lazy = false,
    opts = {
        -- TODO: Opts are under development
    }
}
```
