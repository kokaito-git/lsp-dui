-- window.lua
local Shared = require "lsp-dui.shared"
local WindowIDPackage = require "lsp-dui.window_id_package"

---@class Window
local Window = { name = "Window" }
Window.__index = Window
-- Prevent modification of properties by accident
Window.__newindex = function(self, key, value)
  Shared.bad_assignment_handler(self, self.name, key, value)
end
-- Prevent access to the metatable
Window.__metatable = false

function Window.new(orig_buf, orig_win, opts)
  ---@class Window
  local o = setmetatable({}, Window)
  -- Aquí iría la implementación del constructor
  return o
end

function Window:orig_buf()
  -- Aquí iría la implementación del método orig_buf
end

function Window:orig_win()
  -- Aquí iría la implementación del método orig_win
end

function Window:buf()
  -- Aquí iría la implementación del método buf
end

function Window:win()
  -- Aquí iría la implementación del método win
end

function Window:winpkg()
  -- Aquí iría la implementación del método winpkg
end

function Window:wintype()
  -- Aquí iría la implementación del método type
end

function Window:winorder()
  -- Aquí iría la implementación del método order
end

return Window
