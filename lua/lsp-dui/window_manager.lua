-- window_manager.lua
local Shared = require "lsp-dui.shared"
local Constants = require "lsp-dui.constants"
local LDWindow = require "lsp-dui.window"
local LDWindowRegistry = require "lsp-dui.window_registry"

---@class LDWindowManager
local LDWindowManager = { name = "LDWindowManager" }
LDWindowManager.__index = LDWindowManager
-- Prevent modification of properties by accident
LDWindowManager.__newindex = function(self, key, value)
  Shared.bad_assignment_handler(self, self.name, key, value)
end
-- Prevent access to the metatable
LDWindowManager.__metatable = false

function LDWindowManager.new(opts)
  ---@class LDWindowManager
  local o = setmetatable({}, LDWindowManager)
  -- Aquí iría la implementación del constructor
  o._running = false
  o._registry = LDWindowRegistry.new()
  return o
end

function LDWindowManager:is_running()
  return self._running
end

function LDWindowManager:start()
  if self._running then
    vim.notify("WindowManager is already running.", vim.log.levels.WARN)
    return
  end
  self._running = true
  -- CODE HERE
end

function LDWindowManager:stop()
  if not self._running then
    vim.notify("WindowManager is not running.", vim.log.levels.WARN)
    return
  end
  -- TODO: Cerrar ventanas abiertas antes de limpiar el registro
  self._registry:clear()
  self._running = false
end

function LDWindowManager:request_window(opts)
  local orig_buf = vim.api.nvim_get_current_buf()
  local orig_win = vim.api.nvim_get_current_win()

  local prev_win = self._registry:get(orig_buf)
  if prev_win ~= nil then
    -- La ventana ya existe
    return prev_win:idpkg()
  end

  -- La ventana no existe, crear una nueva
  local win_opts = {
    target_win = opts and opts.target_win or orig_win,
    autofocus = opts and opts.autofocus or Constants.DEFAULT_OPTS.default_autofocus,
    type = opts and opts.type or Constants.DEFAULT_OPTS.default_type,
    order = opts and opts.order or Constants.DEFAULT_OPTS.default_order,
  }
  local win = LDWindow.new(orig_buf, orig_win, win_opts)
  if win == nil then
    vim.notify("[WindowManager] Failed to create diagnostic window.", vim.log.levels.ERROR)
    return nil
  end

  self._registry:register(win)
  return win:idpkg()
end

return LDWindowManager
