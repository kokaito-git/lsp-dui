--- Anulamos porque tenemos sample_class y sample_module usando CNAME
---@diagnostic disable: duplicate-set-field

local Shared = require "lsp-dui.shared"

--- --------------------------------------------------------------
--- Module definition
--- --------------------------------------------------------------

local mod_props = Shared.LDCustomProps.new {}

---@class CNAMEModule
local MOD_PLACEHOLDERS = {}

---TODO: Document the MNAME module
---@class CNAMEModule
local M = { name = "CNAMEModule" }

--- --------------------------------------------------------------
--- Public Module Functions
--- --------------------------------------------------------------

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
