--- --------------------------------------------------------------
--- Module definition
--- --------------------------------------------------------------

---TODO: Document the LDMetaHandlersModule module
---@class LDMetaHandlersModule
local M = {}

--- --------------------------------------------------------------
--- Public Module Variables
--- --------------------------------------------------------------

M.name = "LDMetaHandlersModule"

--- --------------------------------------------------------------
--- Public Module Functions
--- --------------------------------------------------------------

---Handles property access for class instances that use custom getters.
---@param class table The class or instance where the property is defined.
---@param cname string The class name (used for error messages).
---@param prop string The property being accessed.
---@param custom_getters table<string, boolean>|nil Set of properties with custom getter functions.
---@return any The property value or nil if not found.
function M.class_getters_handler(class, cname, prop, custom_getters)
  if custom_getters and custom_getters[prop] then
    local private_fn = "_" .. prop .. "_get"
    local fn = rawget(class, private_fn)

    if not fn then
      error(("Debes definir el método '%s()' para %s"):format(private_fn, cname))
    end

    return fn(class)
  end

  -- si no está en accesable_props, intentar devolver lo que haya directamente en la tabla
  return rawget(class, prop)
end

---Handles property access for modules that use custom getters.
---@param module table The module where the property is defined.
---@param mname string The module name (used for error messages).
---@param prop string The property being accessed.
---@param custom_getters table<string, boolean>|nil Set of properties with custom getter functions.
---@return any The property value or nil if not found.
function M.module_getters_handler(module, mname, prop, custom_getters)
  if custom_getters and custom_getters[prop] then
    local private_fn = "_" .. prop .. "_get"
    local fn = rawget(module, private_fn)

    if not fn then
      error(("Debes definir la función '%s()' para el módulo %s"):format(private_fn, mname))
    end

    return fn()
  end
  -- si no está en accesable_props, intentar devolver lo que haya directamente en la tabla
  return rawget(module, prop)
end

---Handles property assignment for class instances that use custom setters.
---@param self table The class instance.
---@param cname string The class name (used for error messages).
---@param prop string The property being assigned.
---@param value any The value to assign.
---@param custom_setters table<string, boolean>|nil Set of properties with custom setter functions.
function M.class_setters_handler(self, cname, prop, value, custom_setters)
  if custom_setters and custom_setters[prop] then
    ---Si es una propiedad con setter definido, invocar el setter
    local private_fn = "_" .. prop .. "_set"
    local fn = rawget(self, private_fn)
    fn(self, value)
    return
  end

  if not vim.startswith(prop, "_") then
    ---Impedimos la asignación a propiedades públicas sin setter
    ---El mensaje debe ser claro (no se permiten asignaciones directas a propiedades públicas sin setter)
    ---En inglés, no vayas a decir nada de que es readonly porque el valor puede no existir (mensaje no apropiado)
    local msg = string.format(
      "Attempt to assign value %s to a public property '%s' of class %s without a setter.",
      vim.inspect(value),
      prop,
      cname
    )
    error(debug.traceback(msg, 3), 0)
    return
  end

  rawset(self, prop, value)
end

---Handles property assignment for modules that use custom setters.
---@param self table The module itself.
---@param mname string The module name (used for error messages).
---@param prop string The property being assigned.
---@param value any The value to assign.
---@param custom_setters table<string, boolean>? Set of properties with custom setter functions.
function M.module_setters_handler(self, mname, prop, value, custom_setters)
  if custom_setters and custom_setters[prop] then
    ---Si es una propiedad con setter definido, invocar el setter
    local private_fn = "_" .. prop .. "_set"
    local fn = rawget(self, private_fn)
    fn(value)
    return
  end

  if not vim.startswith(prop, "_") then
    ---Impedimos la asignación a propiedades públicas sin setter
    ---El mensaje debe ser claro (no se permiten asignaciones directas a propiedades públicas sin setter)
    ---En inglés, no vayas a decir nada de que es readonly porque el valor puede no existir (mensaje no apropiado)
    local msg = string.format(
      "Attempt to assign value %s to a public property '%s' of module %s without a setter.",
      vim.inspect(value),
      prop,
      mname
    )
    error(debug.traceback(msg, 3), 0)
    return
  end

  rawset(self, prop, value)
end
--- --------------------------------------------------------------
--- Metatable adjustments
--- --------------------------------------------------------------

---Metatable to control module property access
M.__index = function(_, key)
  return M.module_getters_handler(M, M.name, key)
end
---Prevent modification of module properties by accident
M.__newindex = function(self, key, value)
  M.module_setters_handler(self, M.name, key, value)
end
---Prevent access to the module metatable
M.__metatable = false
---Assign the metatable to the module
M = setmetatable(M, M)
---Module is ready here. Additional module operations can be added if needed.
return M
