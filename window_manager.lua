-- window_manager.lua
---@class WindowManager
local WindowManager = {}
WindowManager.__index = WindowManager

function WindowManager:new()
  self = setmetatable({}, WindowManager)
  -- Aquí iría la implementación del constructor
  self._running = false
  return self
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

function WindowManager:clean()
  -- Aquí iría la implementación para limpiar recursos
end

return WindowManager
