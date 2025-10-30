local Shared = require "lsp-dui.shared"

local accesable_props = Shared.make_str_set { "cadena" }

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
C.__index = function(self, key)
  return Shared.accesable_props_handler(self, C.name, key, accesable_props)
end
---Prevent modification of class properties by accident
C.__newindex = function(self, key, value)
  Shared.bad_assignment_handler(self, C.name, key, value)
end
---Prevent access to the class metatable
C.__metatable = false

---Assign the class to the module (*)
M.LDProvider = C

--- --------------------------------------------------------------
--- Module Metatable adjustments
--- --------------------------------------------------------------

---Metatable to control module property access
M.__index = M
---Prevent modification of module properties by accident
M.__newindex = function(self, key, value)
  Shared.bad_assignment_handler(self, M.name, key, value)
end
---Prevent access to the module metatable
M.__metatable = false
---Assign the module metatable
M = setmetatable(M, M)
---Module is ready here. Additional module operations can be added if needed.
return M
