-- TODO: Mañana comprobar api, app, y el modulo principal para hacer que encaje aún mejor
-- por ejemplo evitando usar if key == "api" aquí y creando una propiedad en LDApi (si es posible)
-- Seguro que alguna mejora se puede hacer.
local Shared = require "lsp-dui.shared"
local LDApi = require "lsp-dui.api"
local App = require "lsp-dui.app"

---@class LDCoreModule
local LDCoreModule = {
  name = "LDCoreModule",
  _app = App.new(LDApi),
}
LDCoreModule.__index = function(self, key)
  if key == "api" then
    if not self._app:is_running() then
      -- usar rawget para evitar metamétodos al invocar setup
      local setup = rawget(self, "setup")
      setup()
    end
    return LDApi
  end
  return rawget(self, key)
end
-- Prevent modification of properties by accident
LDCoreModule.__newindex = function(self, key, value)
  Shared.bad_assignment_handler(self, self.name, key, value)
end
-- Prevent access to the metatable
LDCoreModule.__metatable = false

function LDCoreModule.setup(opts)
  if LDCoreModule._app:is_running() then
    LDCoreModule._app:stop()
  else
    LDApi._attach(LDCoreModule._app)
  end
  LDCoreModule._app:start(opts)
  return LDCoreModule._app
end

function LDCoreModule.version()
  return LDCoreModule.api.version()
end

local M = setmetatable(LDCoreModule, LDCoreModule) -- Module is ready here
-- ... additional module operations can be added here if needed
return M
