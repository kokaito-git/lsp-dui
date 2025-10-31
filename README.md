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

## Api sample usage

```lua
-- Using the api
local plugin = require("lsp-dui")
local api = plugin.api
if not plugin.is_running then -- evade to overwrite existing setup
    api.setup(opts)
end

local current_opts = api.opts -- returns a copy of the current opts
```
