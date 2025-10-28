-- main module file
local Shared = require "lsp-dui.shared"
local App = require "lsp-dui.app"
local Constants = require "lsp-dui.constants"

local _app = App:new()

---@class DuiCoreModule
---@field setup fun(opts?: DuiAppEntryOpts): any
local M = setmetatable({
  ---@param opts DuiAppEntryOpts?
  setup = function(opts)
    if _app:is_running() then
      _app:stop()
    end
    _app:start(opts)
    return _app
  end,
}, {
  __index = function(self, key)
    if key == "app" then
      if not _app:is_running() then
        -- usar rawget para evitar metamétodos al invocar setup
        local setup = rawget(self, "setup")
        setup()
      end
      return _app
    end
    return rawget(self, key)
  end,

  __newindex = function(self, key, value)
    Shared.bad_assignment_handler(self, Constants.CORE_MODULE_NAME, key, value)
  end,

  -- oculta/bloquea la metatabla a consumidores del módulo
  __metatable = false,
})

return M
