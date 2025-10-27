-- dui_app.lua
-- local M = {}
local WindowManager = require "lsp-dui.window_manager"

---@class DuiApp
local DuiApp = {}
DuiApp.__index = DuiApp

-- Opciones por defecto
---@type DuiAppOpts
local DEFAULT_OPTS = { order = "category" }

-- Lee y valida las opciones pasadas al constructor
---@param opts DuiAppOpts?
---@return DuiAppOpts
local function _read_opts(opts)
  -- Si no se pasan opciones, usar las por defecto
  if not opts then
    return DEFAULT_OPTS
  end

  local validators = {
    ---@param v string
    ---@return boolean
    order = function(v)
      return v == "category" or v == "lines"
    end,
  }

  ---@type table<string, string>
  local errors = {}

  -- Acumulamos errores y corregimos opciones inválidas
  for k, validator in pairs(validators) do
    if not validator(opts[k]) then
      table.insert(errors, string.format("%s=%s (defaulted to: %s)", k, tostring(opts[k]), tostring(DEFAULT_OPTS[k])))
      opts[k] = DEFAULT_OPTS[k]
    end
  end

  if #errors > 0 then
    vim.notify(
      "Invalid lsp-diagnostics-ui options detected, we're going to default them:\n\t" .. table.concat(errors, "\n\t"),
      vim.log.levels.WARN
    )
  end

  -- Devolver opciones posiblemente corregidas aplicando las faltantes por defecto
  return vim.tbl_deep_extend("force", DEFAULT_OPTS, opts)
end

function DuiApp:new(opts)
  self = setmetatable({}, self)
  self._opts = _read_opts(opts)
  vim.notify("LSP Diagnostics UI initialized with options: " .. vim.inspect(self._opts), vim.log.levels.ERROR)
  self._running = false
  self._wm = WindowManager:new()
  return self
end

function DuiApp:is_running()
  return self._running
end

function DuiApp:start()
  if self._running then
    vim.notify("LSP Diagnostics UI is already running.", vim.log.levels.WARN)
    return
  end
  vim.notify("Starting LSP Diagnostics UI...", vim.log.levels.ERROR)
  self._running = true
  -- Aquí iría la lógica para iniciar la aplicación
end

function DuiApp:stop()
  if not self._running then
    vim.notify("LSP Diagnostics UI is not running.", vim.log.levels.WARN)
    return
  end
  -- Aquí iría la lógica para detener la aplicación
  self._running = false
end

return DuiApp
