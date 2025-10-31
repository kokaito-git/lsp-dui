--- Anulamos porque tenemos sample_class y sample_module usando CNAME
---@diagnostic disable: duplicate-set-field

local Shared = require "lsp-dui.shared"

local custom_props = Shared.LDCustomProps.new {}

--- --------------------------------------------------------------
--- Module Definition
--- --------------------------------------------------------------

local mod_props = Shared.LDCustomProps.new {}

---@class CNAMEModule
local MOD_PLACEHOLDERS = {}

---@class CNAMEModule
local M = { name = "CNAMEModule" }

--- --------------------------------------------------------------
--- Class Definition
--- --------------------------------------------------------------

local cls_props = Shared.LDCustomProps.new {}

---@class CNAME
local CLS_PLACEHOLDERS = {}

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
