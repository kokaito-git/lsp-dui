local Shared = require "lsp-dui.shared"
local AppInstanceModule = require "lsp-dui.private.app_instance"

--- --------------------------------------------------------------
--- Module definition
--- --------------------------------------------------------------

local mod_props = Shared.LDCustomProps.new {
  getters = { "is_running", "version", "opts", "_app" },
}

---@class LDApiModule
local MOD_PLACEHOLDERS = {
  ---Versión del plugin
  version = nil, ---@type string
  ---Devuelve true si la aplicación está en ejecución, false en caso contrario.
  is_running = nil, ---@type boolean
  ---Devuelve una copia de las opciones actuales
  opts = nil, ---@class LDInternalPluginOpts
  ---Getter privado conveniente para acceder a la instancia de la aplicación
  _app = nil, ---@class LDApp
}

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
  ---Referencia a la instancia de la aplicación
  __app = AppInstanceModule.app, ---@class LDApp?
}

--- --------------------------------------------------------------
--- Public Module Functions
--- --------------------------------------------------------------

---Getter privado para poder acceder a app desde la api con motivos de desarrollo y testing
---@return LDApp
function M.__app_get() --- GETTER: _app
  return M.__app
end

---Devuelve la versión del plugin
function M._version_get() --- GETTER: version
  return M._app.version
end

---Devuelve true si la aplicación está en ejecución, false en caso contrario.
function M._is_running_get() --- GETTER: is_running
  return M._app.is_running
end

---Devuelve una copia de las opciones actuales
---Error: Si la aplicación no está en ejecución.
function M._opts_get() --- GETTER: opts
  return M._app.opts
end

---Función para configurar o re-configurar el plugin.
---Si la aplicación ya está en ejecución se detiene y se inicia con la nueva configuración (por tanto
---si no se proporciona configuración se re/inicia con los valores por defecto).
---@param opts LDPluginOpts? Configuración para la aplicación. Si es nil se usaran los valores por defecto.
function M.setup(opts)
  AppInstanceModule.setup(opts)
end

---Reinicia la aplicación conservando los settings actuales. Si la aplicación no está en ejecución se
---inicia con los settings por defecto.
function M.restart()
  if not M._app.is_running then
    return AppInstanceModule.setup()
  end
  return AppInstanceModule.restart()
end

---Detiene la aplicación. Si la aplicación no está en ejecución no hace nada.
function M.stop()
  if not M._app.is_running then
    return
  end
  M._app:stop()
end

function M.request_window(opts)
  return M._app:request_window(opts)
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
---Assign the metatable to the module
M = setmetatable(M, M)
---Module is ready here. Additional module operations can be added if needed.
return M
