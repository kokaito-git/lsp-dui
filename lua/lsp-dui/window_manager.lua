-- window_manager.lua
local Shared = require "lsp-dui.shared"

---@class WindowManager
local WindowManager = { name = "WindowManager" }
WindowManager.__index = WindowManager
-- Prevent modification of properties by accident
WindowManager.__newindex = function(self, key, value)
  Shared.bad_assignment_handler(self, self.name, key, value)
end
-- Prevent access to the metatable
WindowManager.__metatable = false

function WindowManager.new(opts)
  ---@class WindowManager
  local o = setmetatable({}, WindowManager)
  -- Aquí iría la implementación del constructor
  o._running = false
  return o
end

function WindowManager:is_running()
  -- Aquí iría la implementación para verificar si está en ejecución
  return false
end

function WindowManager:start()
  if self._running then
    vim.notify("WindowManager is already running.", vim.log.levels.WARN)
    return
  end
  self._running = true
  -- Aquí iría la implementación para iniciar el gestor de ventanas
end

function WindowManager:stop()
  if not self._running then
    vim.notify("WindowManager is not running.", vim.log.levels.WARN)
    return
  end
  -- Aquí iría la implementación para detener el gestor de ventanas
  self._running = false
end

return WindowManager
