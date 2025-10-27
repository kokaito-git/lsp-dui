-- -- init.lua
-- local M = {}
-- local DuiApp = require "lsp-dui.app"
--
-- ---@param opts DuiAppOpts? Opciones de configuración
-- function M.setup(opts)
--   local app = DuiApp:new(opts)
--   app:start()
-- end
--
-- return M

local DuiApp = require("lsp-dui.dui_app")
return {
  config = function(plugin)
    local app = DuiApp(plugin.opts)
    app:start()
  end,
}

