local MH = require "lsp-dui.shared.meta_handlers"

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

M.class_getters_handler = MH.class_getters_handler
M.module_getters_handler = MH.module_getters_handler
M.class_setters_handler = MH.class_setters_handler
M.module_setters_handler = MH.module_setters_handler

--- UNUSED:
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

--- UNUSED:
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

--- UNUSED:
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

--- UNUSED:
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
M.__index = function(_, key)
  return MH.module_getters_handler(M, M.name, key)
end
---Prevent modification of module properties by accident
M.__newindex = function(self, key, value)
  MH.module_setters_handler(self, M.name, key, value)
end
---Prevent access to the module metatable
M.__metatable = false
---Assign the metatable to the module
M = setmetatable(M, M)
---Module is ready here. Additional module operations can be added if needed.
return M
