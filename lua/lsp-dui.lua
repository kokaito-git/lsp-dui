-- main module file
local App = require "lsp-dui.app"

---@class DuiAppModule
local M = {}

---@param opts DuiAppEntryOpts?
M.setup = function(opts)
  M.app = App:new(opts)
  M.app:start()
end

return M
