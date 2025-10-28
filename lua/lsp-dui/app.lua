-- dui_app.lua
-- local M = {}
local WindowManager = require "lsp-dui.window_manager"
local Private = require "lsp-dui.private"
local Shared = require "lsp-dui.shared"

---@class DuiApp
local DuiApp = { name = "DuiApp" }
DuiApp.__index = DuiApp
-- Prevent modification of properties by accident
DuiApp.__newindex = function(self, key, value)
  Shared.bad_assignment_handler(self, self.name, key, value)
end
-- Prevent access to the metatable
DuiApp.__metatable = false

function DuiApp.new()
  ---@class DuiApp
  local o = setmetatable({}, DuiApp)
  o._opts = nil
  o._running = false
  o._wm = WindowManager.new()
  return o
end

function DuiApp:is_running()
  return self._running
end

function DuiApp:start(opts)
  if self._running then
    vim.notify("LSP Diagnostics UI is already running.", vim.log.levels.WARN)
    return
  end
  self._running = true
  self._opts = Private._read_opts(opts)
  self._wm:start()
end

function DuiApp:stop()
  if not self._running then
    vim.notify("LSP Diagnostics UI is not running.", vim.log.levels.WARN)
    return
  end
  self._wm:stop()
  self._opts = nil
  self._running = false
end

function DuiApp:restart(opts)
  vim.notify("Restarting LSP Diagnostics UI...", vim.log.levels.INFO)
  self:stop()
  self:start(opts)
end

function DuiApp:get_opts()
  return vim.deepcopy(self._opts)
end

return DuiApp
