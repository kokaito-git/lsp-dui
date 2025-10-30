local Shared = require "lsp-dui.shared"

--- GETTERS:
local module_getters = Shared.make_str_set { "_app" }

--- --------------------------------------------------------------
--- Module definition
--- --------------------------------------------------------------

---Módulo de la API pública del plugin LSP-DUI Ofrece métodos para interactuar con la aplicación central
---del plugin.
---@class LDApiModule
local M = {
  ---Nombre del módulo (class property)
  name = "LDApiModule",
  ---Módulo compartido (class property)
  shared = Shared,
  ---Constantes del plugin (class property)
  constants = require "lsp-dui.constants",
  ---External App instance reference (class property)
  ---@class LDApp
  _app = nil,
}

--- --------------------------------------------------------------
--- Private Module Functions
--- --------------------------------------------------------------

---Grants the API module access to the application instance.
---@param app LDApp
function M._attach(app)
  if M._app then
    return
  end
  M.__app = app
end

--- --------------------------------------------------------------
--- Public Module Functions
--- --------------------------------------------------------------

---Getter privado para poder acceder a app desde la api con motivos de desarrollo y testing
function M.__app_get() --- GETTER: _app
  return M.__app
end

---Devuelve la versión del plugin
function M.version()
  assert(M._app ~= nil, "LDApi:version: App instance is not attached.")
  return M._app:version()
end

---Devuelve true si la aplicación está en ejecución
function M.is_running()
  assert(M._app ~= nil, "LDApi:is_running: App instance is not attached.")
  return M._app:is_running()
end

---Inicia la aplicación (recibe las opciones indicadas en setup)
---Error: Si la aplicación ya está en ejecución.
function M.start(opts)
  assert(M._app ~= nil, "LDApi:start: App instance is not attached.")
  return M._app:start(opts)
end

---Detiene la aplicación (limpia todos los recursos)
---Error: Si la aplicación no está en ejecución.
function M.stop()
  assert(M._app ~= nil, "LDApi:stop: App instance is not attached.")
  return M._app:stop()
end

---Reinicia la aplicación (conservando los settings actuales)
---Error: Si la aplicación no está en ejecución.
function M.restart()
  assert(M._app ~= nil, "LDApi:restart: App instance is not attached.")
  return M._app:restart()
end

---Devuelve una copia de las opciones actuales
---Error: Si la aplicación no está en ejecución.
function M.opts()
  assert(M._app ~= nil, "LDApi:opts: App instance is not attached.")
  return M._app:opts()
end

function M.request_window(opts)
  assert(opts ~= M, "You must call LDApi.request_window(...) and not LDApi.request_window:LDApi(...)")
  assert(M._app ~= nil, "LDApi:request_window: App instance is not attached.")
  return M._app:request_window(opts)
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
---Assign the metatable to the module
M = setmetatable(M, M)
---Module is ready here. Additional module operations can be added if needed.
return M
