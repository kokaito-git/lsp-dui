local Shared = require "lsp-dui.shared"

---@class LDApp
local _app = nil

--- Class prperties
---@class LDApiModule
local LDApiModule = {
  name = "LDApi",
  shared = Shared,
  constants = require "lsp-dui.constants",
  _private = require "lsp-dui._private",
}
-- Metatable to control property access
LDApiModule.__index = LDApiModule
-- Prevent modification of properties by accident
LDApiModule.__newindex = function(self, key, value)
  Shared.bad_assignment_handler(self, self.name, key, value)
end
-- Prevent access to the metatable
LDApiModule.__metatable = false

--- Attach the app instance to the API
--- @param app LDApp
function LDApiModule._attach(app)
  assert(_app == nil, "LDApi:_attach: App instance is already attached.")
  _app = app
end
--- --------------------------------------------------------------
--- Public API methods
--- --------------------------------------------------------------

function LDApiModule.version()
  assert(_app ~= nil, "LDApi:version: App instance is not attached.")
  return _app:version()
end

function LDApiModule.is_running()
  assert(_app ~= nil, "LDApi:is_running: App instance is not attached.")
  return _app:is_running()
end

function LDApiModule.start(opts)
  assert(_app ~= nil, "LDApi:start: App instance is not attached.")
  return _app:start(opts)
end

function LDApiModule.stop()
  assert(_app ~= nil, "LDApi:stop: App instance is not attached.")
  return _app:stop()
end

function LDApiModule.restart()
  assert(_app ~= nil, "LDApi:restart: App instance is not attached.")
  return _app:restart()
end

function LDApiModule.opts()
  assert(_app ~= nil, "LDApi:opts: App instance is not attached.")
  return _app:opts()
end

function LDApiModule.request_window(opts)
  assert(opts ~= LDApiModule, "You must call LDApi.request_window(...) and not LDApi.request_window:LDApi(...)")
  assert(_app ~= nil, "LDApi:request_window: App instance is not attached.")
  return _app:request_window(opts)
end

local M = setmetatable(LDApiModule, LDApiModule) -- Module is ready here
-- ... additional module operations can be added here if needed
return M
