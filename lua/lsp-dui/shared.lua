local M = {}

-- Reports an attempt to modify a read-only property.
---@param cname string The name of the class where the assignment was attempted.
---@param prop string The name of the property that was attempted to be modified.
---@param value any The value that was attempted to be assigned.
function M.report_bad_assignement(cname, prop, value)
  local msg = string.format(
    "Attempt to modify read-only property '%s' of %s with value %s.",
    prop,
    cname,
    vim.inspect(value)
  )
  error(debug.traceback(msg, 2), 0)
end

-- Default __newindex for classes: prevents accidental property modifications.
-- MUST be called via a callback passing `self` first; never invoke directly.
-- Uses a trimmed traceback to hide __newindex in errors.
---@param class table The class table where the assignment was attempted.
---@param cname string The name of the class where the assignment was attempted.
---@param prop string The name of the property that was attempted to be modified.
---@param value any The value that was attempted to be assigned.
---@param allowed_props? string[] A list of property names that are allowed to be modified.
---@return nil
function M.bad_assignment_handler(class, cname, prop, value, allowed_props)
  if not vim.startswith(prop, "_") then
    if not vim.tbl_contains(allowed_props or {}, prop) then
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

return M
