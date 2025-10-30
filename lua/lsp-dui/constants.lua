local Shared = require "lsp-dui.shared"

--- --------------------------------------------------------------
--- Module definition
--- --------------------------------------------------------------

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
