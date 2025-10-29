local Shared = require "lsp-dui.shared"
local Constants = require "lsp-dui.constants"

local M = {}

-- Lee y valida las opciones pasadas al constructor
---@param opts LDPluginOpts?
---@return LDInternalPluginOpts
local function _read_opts(opts)
  -- Si no se pasan opciones, usar las por defecto
  if not opts or vim.tbl_isempty(opts) then
    return Constants.DEFAULT_OPTS
  end

  local validators = {
    ---@param v string
    ---@return boolean
    default_type = function(v)
      return v == "buffer" or v == "line"
    end,
    default_order = function(v)
      return v == "category" or v == "lines"
    end,
    default_autofocus = function(v)
      return type(v) == "boolean"
    end,
  }

  ---@type table<string, string>
  local errors = {}
  local defaulted = vim.tbl_deep_extend("force", Constants.DEFAULT_OPTS, opts)

  -- Acumulamos errores y corregimos opciones inválidas
  for k, validator in pairs(validators) do
    if not validator(defaulted[k]) then
      table.insert(
        errors,
        string.format(
          "%s=%s (defaulted to: %s)",
          k,
          tostring(defaulted[k]),
          tostring(Constants.DEFAULT_OPTS[k])
        )
      )
      defaulted[k] = Constants.DEFAULT_OPTS[k]
    end
  end

  if #errors > 0 then
    vim.notify(
      "Invalid lsp-diagnostics-ui options detected, we're going to default them:\n\t"
        .. table.concat(errors, "\n\t"),
      vim.log.levels.WARN
    )
  end

  -- Devolver opciones posiblemente corregidas aplicando las faltantes por defecto
  return defaulted
end

--- LDApp representa la aplicación principal del plugin. Gestiona el ciclo de vida y ofrece
--- una interfaz para interactuar con el plugin, como reiniciarlo, iniciar acciones, etc.
---@class LDApp
local C = {
  name = "LDApp",
}
C.__index = C
-- Prevent modification of properties by accident
C.__newindex = function(self, key, value)
  Shared.bad_assignment_handler(self, self.name, key, value)
end
-- Prevent access to the metatable
C.__metatable = false

--- Crea una nueva instancia de LDApp (se hace automáticamente)
function C.new()
  ---@class LDApp
  local o = setmetatable({}, C)
  o._opts = nil
  o._running = false
  return o
end

--- Devuelve la versión del plugin
function C:version()
  return Constants.PLUGIN_VERSION
end

--- Devuelve true si la aplicación está en ejecución
function C:is_running()
  return self._running
end

--- Inicia la aplicación (recibe las opciones indicadas en setup)
--- Error: Si la aplicación ya está en ejecución.
function C:start(opts)
  if self._running then
    vim.notify("LSP Diagnostics UI is already running.", vim.log.levels.WARN)
    return
  end
  self._running = true
  self._opts = _read_opts(opts)
  -- TODO: Continuar con la inicialización
end

--- Detiene la aplicación (limpia todos los recursos)
--- Error: Si la aplicación no está en ejecución.
function C:stop()
  if not self._running then
    vim.notify("LSP Diagnostics UI is not running.", vim.log.levels.WARN)
    return
  end
  -- TODO: Limpiar recursos
  self._opts = nil
  self._running = false
end

--- Reinicia la aplicación (conservando los settings actuales)
--- Error: Si la aplicación no está en ejecución.
function C:restart()
  if not self._running then
    vim.notify("LSP Diagnostics UI is not running.", vim.log.levels.WARN)
    return
  end
  self:stop()
  local opts = self:opts()
  ---@diagnostic disable-next-line: param-type-mismatch
  self:start(opts)
end

--- Devuelve una copia de las opciones actuales
--- Error: Si la aplicación no está en ejecución.
function C:opts()
  if not self._running then
    vim.notify("LSP Diagnostics UI is not running.", vim.log.levels.WARN)
    error "Cannot get options when the application is not running."
  end
  return vim.deepcopy(self._opts)
end

-- TODO: Comentar esta función.
function C:request_window(opts)
  -- TODO: Implementar la lógica para solicitar una ventana
end

M.LDApp = C
return M
