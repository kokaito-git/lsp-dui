-- window.lua
---@class Window
local Window = {}
Window.__index = Window

function Window:new(opts)
  self = setmetatable({}, Window)
  -- Aquí iría la implementación del constructor
  return self
end

function Window:get_orig_bufid()
  -- Aquí iría la implementación para obtener el buffer original
end

function Window:get_orig_winid()
  -- Aquí iría la implementación para obtener la ventana original
end

function Window:get_bufid()
  -- Aquí iría la implementación para obtener el buffer asociado
end

function Window:get_winid()
  -- Aquí iría la implementación para obtener la ventana asociada
end

function Window:get_wintype()
  -- Aquí iría la implementación para obtener el tipo de ventana
end

function Window:get_order()
  -- Aquí iría la implementación para obtener el orden de agrupación
end

return Window
