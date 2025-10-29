local Shared = require "lsp-dui.shared"

---@class LDApp
local _app = nil

--- Módulo de la API pública del plugin LSP-DUI
--- Ofrece métodos para interactuar con la aplicación central del plugin.
---@class LDApiModule
local M = {
  ---Nombre del módulo (class property)
  name = "LDApi",
  ---Módulo compartido (class property)
  shared = Shared,
  ---Constantes del plugin (class property)
  constants = require "lsp-dui.constants",
}
-- Metatable to control property access
M.__index = function(self, key)
  if key == "_app" then
    return _app -- retorna la variable local
  end
  return rawget(M, key) -- busca en M sin activar metatable
end
-- Prevent modification of properties by accident
M.__newindex = function(self, key, value)
  Shared.bad_assignment_handler(self, self.name, key, value)
end
-- Prevent access to the metatable
M.__metatable = false

--- Attach the app instance to the API
--- @param app LDApp
function M._attach(app)
  if _app then
    return
  end
  _app = app
end
--- --------------------------------------------------------------
--- Public API methods
--- --------------------------------------------------------------

---Devuelve la versión del plugin
function M.version()
  assert(_app ~= nil, "LDApi:version: App instance is not attached.")
  return _app:version()
end

---Devuelve true si la aplicación está en ejecución
function M.is_running()
  assert(_app ~= nil, "LDApi:is_running: App instance is not attached.")
  return _app:is_running()
end

---Inicia la aplicación (recibe las opciones indicadas en setup)
---Error: Si la aplicación ya está en ejecución.
function M.start(opts)
  assert(_app ~= nil, "LDApi:start: App instance is not attached.")
  return _app:start(opts)
end

---Detiene la aplicación (limpia todos los recursos)
---Error: Si la aplicación no está en ejecución.
function M.stop()
  assert(_app ~= nil, "LDApi:stop: App instance is not attached.")
  return _app:stop()
end

---Reinicia la aplicación (conservando los settings actuales)
---Error: Si la aplicación no está en ejecución.
function M.restart()
  assert(_app ~= nil, "LDApi:restart: App instance is not attached.")
  return _app:restart()
end

---Devuelve una copia de las opciones actuales
---Error: Si la aplicación no está en ejecución.
function M.opts()
  assert(_app ~= nil, "LDApi:opts: App instance is not attached.")
  return _app:opts()
end

function M.request_window(opts)
  assert(opts ~= M, "You must call LDApi.request_window(...) and not LDApi.request_window:LDApi(...)")
  assert(_app ~= nil, "LDApi:request_window: App instance is not attached.")
  return _app:request_window(opts)
end

M = setmetatable(M, M) -- Module is ready here
-- ... additional module operations can be added here if needed
return M
