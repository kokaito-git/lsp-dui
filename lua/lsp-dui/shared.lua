--- --------------------------------------------------------------
--- Module definition
--- --------------------------------------------------------------

---@class LDSharedModule
local M = {}

--- --------------------------------------------------------------
--- Public Module Variables
--- --------------------------------------------------------------

M.name = "LDSharedModule"

--- --------------------------------------------------------------
--- Public Module Functions
--- --------------------------------------------------------------

---Creates a set from a list of strings.
---@param list string[]  Lista de strings
---@return table<string, true>  Conjunto donde cada string es clave
function M.make_str_set(list)
  local t = {}
  for _, v in ipairs(list) do
    t[v] = true
  end
  return t
end

---Default __index for classes: Traduce las llamadas de `miembro` a `_miembro`
---con el fin de exponer propiedades de solo lectura.
---@param class table The class table where the access was attempted.
---@param cname string The name of the class where the access was attempted.
---@param prop string The name of the property that was attempted to be accessed.
---@param accesable_props? table<string, true> Optional set of unmodifiable property names.
---@return any The value of the property.
function M.accesable_props_handler(class, cname, prop, accesable_props)
  if accesable_props and accesable_props[prop] then
    local private_prop = "_" .. prop
    return rawget(class, private_prop)
  end
  return rawget(class, prop)
end

---Default __newindex for classes: prevents accidental property modifications.
---MUST be called via a callback passing `self` first; never invoke directly.
---Uses a trimmed traceback to hide __newindex in errors.
---@param class table The class table where the assignment was attempted.
---@param cname string The name of the class where the assignment was attempted.
---@param prop string The name of the property that was attempted to be modified.
---@param value any The value that was attempted to be assigned.
---@param modifiable_props? table<string, true> Optional set of modifiable property names.
---@return nil
function M.bad_assignment_handler(class, cname, prop, value, modifiable_props)
  if not vim.startswith(prop, "_") then
    if not (modifiable_props and modifiable_props[prop]) then
      local msg = string.format(
        "Attempt to modify read-only property '%s' of %s with value %s.",
        prop,
        cname,
        vim.inspect(value)
      )
      error(debug.traceback(msg, 3), 0)
      return
    end
  end
  rawset(class, prop, value) -- Allow setting private properties
end

---Función que acepta todos los number que le pases y genera una key separada por ':'
---@param ... number Valores para generar la key
---@return string
function M.generate_key(...)
  local args = { ... }
  local key_parts = {}
  for _, v in ipairs(args) do
    table.insert(key_parts, tostring(v))
  end
  return table.concat(key_parts, ":")
end

---Función inversa a `generate_key`, devuelve una tabla con los números
---@param key string Key generada por `generate_key`
---@return number[]
function M.parse_key(key)
  local parts = vim.split(key, ":")
  local numbers = {}
  for _, part in ipairs(parts) do
    table.insert(numbers, tonumber(part))
  end
  return numbers
end

---@generic T
---@param t T[] Table of elements of type T
---@return ... T Unpacks the elements of the table
function M.table_unpack(t)
  ---@diagnostic disable-next-line: deprecated
  local _unpack = unpack or table.unpack
  return _unpack(t)
end

---Normaliza el path cambiando \\ por /
---En caso de que el path sea nulo o vacío o inválido, devuelve nil
---@param path string El path a normalizar
---@return string
function M.normalize_path(path)
  if type(path) ~= "string" then
    error "Path must be a valid string"
  end
  -- Normalizar barras para Windows
  path = path:gsub("\\", "/")
  return path
end

---Acorta y normaliza el path cambiando \\ por / y acortando el home a ~
---@param path string El path a acortar
---@return string
function M.shorten_path(path)
  if type(path) ~= "string" then
    error "Path must be a valid string"
  end

  local home = vim.loop.os_homedir()
  if not home or home == "" then
    return M.normalize_path(path)
  end

  -- Normalizar barras para Windows
  home = M.normalize_path(home)
  path = M.normalize_path(path)

  if path:sub(1, #home) == home then
    return "~" .. path:sub(#home + 1)
  end

  return path
end

--- Recorta y normaliza path dejando solo `depth` carpetas antes del archivo.
--- @param path string El path a recortar
--- @param depth number La cantidad de carpetas a mantener antes del archivo
--- @return string
function M.trim_path(path, depth)
  if type(path) ~= "string" then
    error "Path must be a valid string"
  end

  if type(depth) ~= "number" or depth < 0 then
    error "Depth must be a non-negative number"
  end

  if path == "" then
    return ""
  end

  path = path:gsub("\\", "/") -- Normalizar barras para Windows
  -- trimempty para evitar partes vacías
  -- Ejemplo: "/home/user/docs/file.txt"
  -- Con trimempty = true, obtenemos {"home", "user", "docs", "file.txt"}
  -- Sin trimempty, obtenemos {"", "home", "user", "docs", "file.txt"}
  local parts = vim.split(path, "/", { trimempty = true })
  local len = #parts
  -- Si el path es más corto que la profundidad solicitada, devolver el path completo
  if len <= depth + 1 then
    return path
  end
  -- Construir el path recortado
  local trimmed_parts = {}
  for i = len - depth, len do
    table.insert(trimmed_parts, parts[i])
  end

  return table.concat(trimmed_parts, "/")
end

--- --------------------------------------------------------------
--- Metatable adjustments
--- --------------------------------------------------------------

---Metatable to control module property access
M.__index = M
---Prevent modification of module properties by accident
M.__newindex = function(self, key, value)
  M.bad_assignment_handler(self, M.name, key, value)
end
---Prevent access to the module metatable
M.__metatable = false
---Assign the module metatable
M = setmetatable(M, M)
return M
