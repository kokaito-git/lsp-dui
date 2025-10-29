local LDWindowManager = require "lsp-dui.window_manager"
local Private = require "lsp-dui._private"
local Shared = require "lsp-dui.shared"
local Constants = require "lsp-dui.constants"

---@class LDApp
local LDApp = {
  name = "LDApp",
}
LDApp.__index = LDApp
-- Prevent modification of properties by accident
LDApp.__newindex = function(self, key, value)
  Shared.bad_assignment_handler(self, self.name, key, value)
end
-- Prevent access to the metatable
LDApp.__metatable = false

function LDApp.new()
  ---@class LDApp
  local o = setmetatable({}, LDApp)
  o._opts = nil
  o._running = false
  o._wm = LDWindowManager.new()
  return o
end

function LDApp:version()
  return Constants.PLUGIN_VERSION
end

function LDApp:is_running()
  return self._running
end

function LDApp:start(opts)
  if self._running then
    vim.notify("LSP Diagnostics UI is already running.", vim.log.levels.WARN)
    return
  end
  self._running = true
  self._opts = Private._read_opts(opts)
  self._wm:start()
end

function LDApp:stop()
  if not self._running then
    vim.notify("LSP Diagnostics UI is not running.", vim.log.levels.WARN)
    return
  end
  self._wm:stop()
  self._opts = nil
  self._running = false
end

function LDApp:restart()
  if not self._running then
    vim.notify("LSP Diagnostics UI is not running.", vim.log.levels.WARN)
    return
  end
  self:stop()
  local opts = self:opts()
  ---@diagnostic disable-next-line: param-type-mismatch
  self:start(opts)
end

function LDApp:opts()
  if not self._running then
    vim.notify("LSP Diagnostics UI is not running.", vim.log.levels.WARN)
    error "Cannot get options when the application is not running."
  end
  return vim.deepcopy(self._opts)
end

function LDApp:request_window(opts)
  if not self._running then
    vim.notify("LSP Diagnostics UI is not running.", vim.log.levels.WARN)
    return nil
  end
  return self._wm:request_window(opts)
end

return LDApp
