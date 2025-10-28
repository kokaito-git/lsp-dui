---@class DuiConstantsModule
local M = {}

M.PLUGIN_NAME = "lsp-diagnostics-ui"
M.PLUGIN_SHORT = "lsp-dui"
M.CORE_MODULE_NAME = "DuiCoreModule"


-- Opciones por defecto
---@type DuiAppOpts
M.DEFAULT_OPTS = { order = "category" }

return M
