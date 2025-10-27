-- dui_app.lua
-- local M = {}
local WindowManager = require "lsp-dui.window_manager"
local P = require "lsp-dui.private"

---@class DuiApp
local DuiApp = {}
DuiApp.__index = DuiApp

function DuiApp:new(opts)
  self = setmetatable({}, self)
  self._opts = P._read_opts(opts)
  self._running = false
  self._wm = WindowManager:new()
  return self
end

function DuiApp:is_running()
  return self._running
end

function DuiApp:start()
  if self._running then
    vim.notify("LSP Diagnostics UI is already running.", vim.log.levels.WARN)
    return
  end
  vim.notify("Starting LSP Diagnostics UI...", vim.log.levels.ERROR)
  self._running = true
  -- Aquí iría la lógica para iniciar la aplicación
end

function DuiApp:stop()
  if not self._running then
    vim.notify("LSP Diagnostics UI is not running.", vim.log.levels.WARN)
    return
  end
  -- Aquí iría la lógica para detener la aplicación
  self._running = false
end

function DuiApp:get_opts()
  vim.notify("LSP Diagnostics UI test function called.", vim.log.levels.ERROR)
  return self._opts
end

return DuiApp
