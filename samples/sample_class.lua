local Shared = require "lsp-dui.shared"

local custom_getters = Shared.make_str_set { "cadena" }
local custom_setters = Shared.make_str_set { "cadena" }

--- --------------------------------------------------------------
--- Module Definition
--- --------------------------------------------------------------

---Module for CNAME class
---@class CNAMEModule
local M = { name = "CNAMEModule" }

--- --------------------------------------------------------------
--- Class Definition
--- --------------------------------------------------------------

---TODO: Document the CNAME class
---@class CNAME
local C = { name = "CNAME" }

--- --------------------------------------------------------------
--- Public Class Methods
--- --------------------------------------------------------------

---TODO: Document the constructor
function C.new()
  ---@class CNAME
  local o = setmetatable({}, C)
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
M.CNAME = C

--- --------------------------------------------------------------
--- Module Metatable adjustments
--- --------------------------------------------------------------

---Metatable to control module property access
M.__index = function(_, key)
  return Shared.module_getters_handler(M, M.name, key)
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
