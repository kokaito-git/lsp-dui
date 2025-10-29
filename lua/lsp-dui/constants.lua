local Shared = require "lsp-dui.shared"

---@class LDConstantsModule
local M = {}

M.PLUGIN_VERSION = "0.0.1"
M.PLUGIN_NAME = "lsp-diagnostics-ui"
M.PLUGIN_SHORT = "lsp-dui"
M.CORE_MODULE_NAME = "LDCoreModule"

-- Opciones por defecto
---@type LDInternalPluginOpts
M.DEFAULT_OPTS = {
  default_order = "category",
  default_type = "buffer",
  default_autofocus = false,
}

---@class LDConstantsModule
local metatable = setmetatable({}, {
  __index = M, -- leer normalmente
  __newindex = function(self, key, value)
    Shared.bad_assignment_handler(self, "LDConstantsModule", key, value)
  end,
  __metatable = false, -- bloquea acceso a la metatable
})

return metatable
