local Shared = require "lsp-dui.shared"

--- --------------------------------------------------------------
--- Module Definition
--- --------------------------------------------------------------

local mod_props = Shared.LDCustomProps.new {}

---Module for LDProvider class
---@class LDProviderModule
local M = { name = "LDProviderModule" }

--- --------------------------------------------------------------
--- Class Definition
--- --------------------------------------------------------------

local cls_props = Shared.LDCustomProps.new {}

---@class LDProvider
local CLS_PLACEHOLDERS = {}

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
  return Shared.class_getters_handler(C, self, key, cls_props.getters)
end
---Prevent modification of class properties by accident
C.__newindex = function(self, key, value)
  -- Shared.bad_assignment_handler(C, C.name, key, value)
  Shared.class_setters_handler(C, self, key, value, cls_props.setters)
end
---Prevent access to the class metatable
C.__metatable = false

---Assign the class to the module (*)
M.C = C

--- --------------------------------------------------------------
--- Module Metatable adjustments
--- --------------------------------------------------------------

-- ---Metatable to control module property access
M.__index = function(_, key)
  return Shared.module_getters_handler(M, key, mod_props.getters)
end
---Prevent modification of module properties by accident
M.__newindex = function(self, key, value)
  Shared.module_setters_handler(M, key, value, mod_props.setters)
end
---Prevent access to the module metatable
M.__metatable = false
---Assign the module metatable
M = setmetatable(M, M)
---Module is ready here. Additional module operations can be added if needed.
return M
