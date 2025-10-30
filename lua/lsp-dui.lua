local App = require("lsp-dui.app").LDApp
local api = require "lsp-dui.api"
local shared = require "lsp-dui.shared"

--- --------------------------------------------------------------
--- Module definition
--- --------------------------------------------------------------

---TODO: Document the MNAME module
---@class LDCoreModule
local M = {
  ---Nombre del módulo
  name = "LDCoreModule",
  ---note: placeholder to be able to comment the api property
  ---@class LDApiModule
  ---Instancia de la aplicación DuiApp. Puedes acceder a ella directamente para manipularla.
  api = nil,
  _app = App.new(),
}

--- --------------------------------------------------------------
--- Public Module Functions
--- --------------------------------------------------------------

---Versión del plugin
function M.version()
  return api.version()
end

---Función para re-configurar el plugin (si no vas a cambiar opciones no la llames)
function M.setup(opts)
  if M._app:is_running() then
    M._app:stop()
  else
    api._attach(M._app) -- attach the app if not already attached
  end
  M._app:start(opts)
  return M
end

---Función para reiniciar el plugin conservando los settigns actuales.
function M.restart()
  vim.notify("Restarting lsp-dui application...", vim.log.levels.INFO)
  local opts = nil
  if M._app:is_running() then
    opts = M._app:opts()
    M._app:stop()
  else
    api._attach(M._app) -- attach the app if not already attached
  end
  ---@diagnostic disable-next-line: param-type-mismatch
  M._app:start(opts)
  return M
end

--- --------------------------------------------------------------
--- Metatable adjustments
--- --------------------------------------------------------------

---Metatable to control module property access
M.__index = function(self, key)
  if key == "api" then
    if not self._app:is_running() then
      -- usar rawget para evitar metamétodos al invocar setup
      local setup = rawget(self, "setup")
      setup()
    end
    return api
  end
  return rawget(self, key)
end
---Prevent modification of module properties by accident
M.__newindex = function(self, key, value)
  shared.bad_assignment_handler(self, self.name, key, value)
end
---Prevent access to the module metatable
M.__metatable = false
---Assign the module metatable
M = setmetatable(M, M)
return M
