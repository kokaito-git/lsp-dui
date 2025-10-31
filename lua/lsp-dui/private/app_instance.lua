local Shared = require "lsp-dui.shared"
local App = require("lsp-dui.app").C

--- --------------------------------------------------------------
--- Module definition
--- --------------------------------------------------------------

local mod_props = Shared.LDCustomProps.new {}

---@class LDSharedModule
local MOD_PLACEHOLDERS = {}

---TODO: Document the LDAppInstanceModule module
---@class LDAppInstanceModule
local M = {}

--- --------------------------------------------------------------
--- Public Module Variables
--- --------------------------------------------------------------

M.name = "LDAppInstanceModule"

M.app = App.new()

function M.setup(config)
  if M.app.is_running then
    M.app:stop()
  end
  M.app:start(config)
end

function M.restart()
  local opts = nil
  if M.app.is_running then
    opts = M.app.opts
    M.app:stop()
  end
  ---@diagnostic disable-next-line: param-type-mismatch
  M.app:start(opts)
end

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
