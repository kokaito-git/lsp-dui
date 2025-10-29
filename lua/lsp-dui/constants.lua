local Shared = require "lsp-dui.shared"

---@class LDConstantsModule
local M = {}

M.name = "LDConstantsModule"

M.PLUGIN_VERSION = "0.0.1"
M.PLUGIN_NAME = "lsp-diagnostics-ui"
M.PLUGIN_SHORT = "lsp-dui"
M.CORE_MODULE_NAME = "LDCoreModule"

-- TODO: Mover a opts_validator.lua

-- Opciones por defecto
---@type LDInternalPluginOpts
M.DEFAULT_OPTS = {
  default_order = "category",
  default_type = "buffer",
  default_autofocus = false,
}

M = setmetatable({}, {
  __index = M, -- leer normalmente
  __newindex = function(self, key, value)
    Shared.bad_assignment_handler(self, "LDConstantsModule", key, value)
  end,
  __metatable = false, -- bloquea acceso a la metatable
})

return M
