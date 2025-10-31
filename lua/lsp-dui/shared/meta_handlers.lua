local Methods = require "lsp-dui.shared.methods"
local TM = Methods.Table

--- --------------------------------------------------------------
--- LDCustomProps class (auxiliary one)
--- --------------------------------------------------------------

---@class LDCustomProps
local LDCustomProps = {}

function LDCustomProps.new(opts)
  ---@class LDCustomProps
  local o = setmetatable({}, LDCustomProps)

  local _opts = opts or {}
  o.getters = TM.normalize_to_table(_opts.getters)
  o.setters = TM.normalize_to_table(_opts.setters)

  return o
end

--- NOTE: Added to M after M = {}

--- --------------------------------------------------------------
--- Module definition
--- --------------------------------------------------------------

local mod_props = LDCustomProps.new {}

---@class LDMetaHandlersModule
local MOD_PLACEHOLDERS = {}

---TODO: Document the LDMetaHandlersModule module
---@class LDMetaHandlersModule
local M = {}

M.LDCustomProps = LDCustomProps

--- --------------------------------------------------------------
--- Public Module Variables
--- --------------------------------------------------------------

M.name = "LDMetaHandlersModule"

--- --------------------------------------------------------------
--- Public Module Functions
--- --------------------------------------------------------------

--- Método estático para manejar getters custom de clases
function M.class_getters_handler(class, self, prop, custom_getters)
  if custom_getters[prop] then
    local private_fn = "_" .. prop .. "_get"
    local fn = rawget(class, private_fn)
    if not fn then
      error(("Getter function '%s' not defined in class '%s'"):format(private_fn, class.name))
    end
    return fn(self)
  end
  return rawget(class, prop)
end

--- Método estático para manejar setters custom de clases
function M.class_setters_handler(class, self, key, value, custom_setters)
  if custom_setters[key] then
    local private_fn = "_" .. key .. "_set"
    local fn = rawget(class, private_fn)
    vim.notify("Valor de fn: " .. vim.inspect(fn))
    if not fn then
      error(("Setter function '%s' not defined in class '%s'"):format(private_fn, class.name))
    end
    fn(self, value)
    return
  end
  rawset(self, key, value)
end

--- Método estático para manejar getters custom de módulos
function M.module_getters_handler(module, prop, custom_getters)
  if custom_getters[prop] then
    local private_fn = "_" .. prop .. "_get"
    local fn = rawget(module, private_fn)
    if not fn then
      error(("Getter function '%s' not defined in module '%s'"):format(private_fn, module.name))
    end
    return fn()
  end
  return rawget(module, prop)
end

--- Método estático para manejar setters custom de módulos
function M.module_setters_handler(module, key, value, custom_setters)
  if custom_setters[key] then
    local private_fn = "_" .. key .. "_set"
    local fn = rawget(module, private_fn)
    if not fn then
      error(("Setter function '%s' not defined in module '%s'"):format(private_fn, module.name))
    end
    fn(value)
    return
  end
  rawset(module, key, value)
end

--- --------------------------------------------------------------
--- Metatable adjustments
--- --------------------------------------------------------------

---Metatable to control module property access
M.__index = function(_, key)
  return M.module_getters_handler(M, key, mod_props.getters)
end
---Prevent modification of module properties by accident
M.__newindex = function(self, key, value)
  M.module_setters_handler(M, key, value, mod_props.setters)
end
---Prevent access to the module metatable
M.__metatable = false
---Assign the metatable to the module
M = setmetatable(M, M)
---Module is ready here. Additional module operations can be added if needed.
return M
