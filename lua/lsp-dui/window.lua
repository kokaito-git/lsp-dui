-- window.lua
local Shared = require "lsp-dui.shared"

---@class Window
local Window = { name = "Window" }
Window.__index = Window
-- Prevent modification of properties by accident
Window.__newindex = function(self, key, value)
  Shared.bad_assignment_handler(self, self.name, key, value)
end
-- Prevent access to the metatable
Window.__metatable = false

function Window.new(opts)
  ---@class Window
  local o = setmetatable({}, Window)
  -- Aquí iría la implementación del constructor
  return o
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
