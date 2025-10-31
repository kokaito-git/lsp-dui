local Shared = require "lsp-dui.shared"
local Api = require "lsp-dui.api"
local AppInstanceModule = require "lsp-dui.private.app_instance"

--- --------------------------------------------------------------
--- Module definition
--- --------------------------------------------------------------

local mod_props = Shared.LDCustomProps.new {
  getters = { "api", "_app", "version" },
}

---@class LDCoreModule
local MOD_PLACEHOLDERS = { -- PLACEHOLDERS for documentation purposes
  --- Acceso a la api pública del plugin
  api = nil, ---@class LDApiModule
  --- (private) Acceso a la instancia de la aplicación para propósitos de desarrollo y testing.
  _app = nil, ---@class LDApp
  --- Versión del plugin
  version = nil, ---@type string
}

---TODO: Document the MNAME module
---@class LDCoreModule
---@class LDCoreModule
local M = {
  ---Nombre del módulo
  name = "LDCoreModule",
  --- Acceso a la api pública del plugin
  _api = Api,
  --- (private) Acceso a la instancia de la aplicación para propósitos de desarrollo y testing.
  __app = AppInstanceModule.app,
}

--- --------------------------------------------------------------
--- Public Module Functions
--- --------------------------------------------------------------

function M._api_get() --- GETTER: api
  return M._api
end

function M.__app_get() --- GETTER: _app
  return M.__app
end

function M._version_get() --- GETTER: version
  return M._api.version
end

---Función para configurar o re-configurar el plugin.
---Si la aplicación ya está en ejecución se detiene y se inicia con la nueva configuración (por tanto
---si no se proporciona configuración se re/inicia con los valores por defecto).
---
---Nota: Si quieres más opciones accede a la api directamente.
---@param opts LDPluginOpts? Configuración para la aplicación. Si es nil se usaran los valores por defecto.
function M.setup(opts)
  M._api.setup(opts)
  return M
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
