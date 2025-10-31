local Shared = require "lsp-dui.shared"

--- --------------------------------------------------------------
--- Module definition
--- --------------------------------------------------------------

local mod_props = Shared.LDCustomProps.new {}

---@class LDConstantsModule
local MOD_PLACEHOLDERS = {}

---@class LDConstantsModule
local M = {}

--- --------------------------------------------------------------
--- Public Module Variables
--- --------------------------------------------------------------

M.name = "LDConstantsModule"

M.PLUGIN_VERSION = "0.0.1"
M.PLUGIN_NAME = "lsp-diagnostics-ui"
M.PLUGIN_SHORT = "lsp-dui"
M.CORE_MODULE_NAME = "LDCoreModule"

---Opciones por defecto
---@type LDInternalPluginOpts
M.DEFAULT_OPTS = {
  default_order = "category",
  default_type = "buffer",
  default_autofocus = false,
}

--- --------------------------------------------------------------
--- Metatable adjustments
--- --------------------------------------------------------------

---Metatable to control module property access
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
return M
