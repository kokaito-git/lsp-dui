local Shared = require "lsp-dui.shared"


--- --------------------------------------------------------------
--- Module Definition
--- --------------------------------------------------------------

---Module for LDProvider class
---@class LDProviderModule
local M = { name = "LDProviderModule" }

--- --------------------------------------------------------------
--- Class Definition
--- --------------------------------------------------------------

---TODO: Document the LDProvider class
---@class LDProvider
local C = { name = "LDProvider" }

--- --------------------------------------------------------------
--- Public Class Methods
--- --------------------------------------------------------------

---TODO: Document the constructor
function C.new()
  ---@class LDProvider
  local o = setmetatable({}, C)
  o._cadena = "pepe"
  return o
end


--- --------------------------------------------------------------
--- Class Metatable adjustments
--- --------------------------------------------------------------

---Metatable to control class property access
C.__index = function(_, key)
  return Shared.class_getters_handler(C, C.name, key)
end
---Prevent modification of class properties by accident
C.__newindex = function(self, key, value)
  -- Shared.bad_assignment_handler(C, C.name, key, value)
  Shared.class_setters_handler(self, C.name, key, value)
end
---Prevent access to the class metatable
C.__metatable = false

---Assign the class to the module (*)
M.LDProvider = C

--- --------------------------------------------------------------
--- Module Metatable adjustments
--- --------------------------------------------------------------

---Metatable to control module property access
M.__index = function(self, key)
  return Shared.module_getters_handler(self, M.name, key)
end
---Prevent modification of module properties by accident
M.__newindex = function(self, key, value)
  Shared.module_setters_handler(self, M.name, key, value)
end
---Prevent access to the module metatable
M.__metatable = false
---Assign the module metatable
M = setmetatable(M, M)
---Module is ready here. Additional module operations can be added if needed.
return M
