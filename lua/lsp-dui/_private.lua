local Constants = require "lsp-dui.constants"

---@class LDPrivateModule
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

M._read_opts = _read_opts
return M
