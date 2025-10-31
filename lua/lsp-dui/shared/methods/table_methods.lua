local M = {}
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

---Normalizes a list of strings into a set, returning nil if the list is empty or nil.
---@param list string[]|nil  Lista de strings
---@return table<string, true>|nil  Conjunto de strings o nil
function M.normalize_to_nil(list)
  if not list or vim.tbl_isempty(list) then
    return nil
  end
  return M.make_str_set(list)
end

---Normalizes a list of strings into a set, returning an empty table if the list is empty or nil.
---@param list string[]|nil  Lista de strings
---@return table<string, true>  Conjunto de strings
function M.normalize_to_table(list)
  if not list or vim.tbl_isempty(list) then
    return {}
  end
  return M.make_str_set(list)
end

return M
