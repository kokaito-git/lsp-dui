local AppModule = require "lsp-dui.app"
local App = require("lsp-dui.app").LDApp
local Api = require "lsp-dui.api"
local Shared = require "lsp-dui.shared"

--- GETTERS:
local module_getters = Shared.make_str_set { "api", "_app"}

--- --------------------------------------------------------------
--- Module definition
--- --------------------------------------------------------------

---TODO: Document the MNAME module
---@class LDCoreModule
local M = {
  ---Nombre del módulo
  name = "LDCoreModule",
  __app = App.new(),
}

--- --------------------------------------------------------------
--- Public Module Functions
--- --------------------------------------------------------------

---Getter público para acceder a la api del plugin
---Inicializa implícitamente la aplicación si no está en ejecución con valores por defecto.
function M._api_get() --- GETTER: api
  if not M.__app:is_running() then
    M.setup()
  end
  return Api
end

---Getter privado para poder acceder a app desde el módulo principal con motivos de desarrollo y testing
---Inicializa implícitamente la aplicación si no está en ejecución con valores por defecto.
function M.__app_get() --- GETTER: _app
  if not M.__app:is_running() then
    M.setup()
  end
  return M.__app
end

---Versión del plugin
function M.version()
  return Api.version()
end

---Función para re-configurar el plugin (si no vas a cambiar opciones no la llames)
function M.setup(opts)
  if M.__app:is_running() then
    M.__app:stop()
  else
    Api._attach(M.__app) -- attach the app if not already attached
  end
  M.__app:start(opts)
  return M
end

---Función para reiniciar el plugin conservando los settigns actuales.
function M.restart()
  local opts = nil
  if M.__app:is_running() then
    opts = M.__app:opts()
    M.__app:stop()
  else
    Api._attach(M.__app) -- attach the app if not already attached
  end
  ---@diagnostic disable-next-line: param-type-mismatch
  M.__app:start(opts)
  return M
end

--- --------------------------------------------------------------
--- Metatable adjustments
--- --------------------------------------------------------------

---Metatable to control module property access
M.__index = function(_, key)
  return Shared.module_getters_handler(M, M.name, key, module_getters)
end
---Prevent modification of module properties by accident
M.__newindex = function(self, key, value)
  Shared.module_setters_handler(self, M.name, key, value)
end
---Prevent access to the module metatable
M.__metatable = false
---Assign the module metatable
M = setmetatable(M, M)
return M
