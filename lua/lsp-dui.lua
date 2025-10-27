-- main module file
local App = require "lsp-dui.app"

---@class DuiAppModule
local M = {}

---@param opts DuiAppOpts?
M.setup = function(opts)
  M.app = App:new(opts)
end

return M
