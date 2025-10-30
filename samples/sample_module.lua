local Shared = require "lsp-dui.shared"

--- --------------------------------------------------------------
--- Module definition
--- --------------------------------------------------------------

---TODO: Document the MNAME module
---@class MNAME
local M = {}

--- --------------------------------------------------------------
--- Public Module Variables
--- --------------------------------------------------------------

M.name = "MNAME"

--- --------------------------------------------------------------
--- Public Module Functions
--- --------------------------------------------------------------

--- --------------------------------------------------------------
--- Metatable adjustments
--- --------------------------------------------------------------

---Metatable to control module property access
M.__index = function(_, key)
  return Shared.module_getters_handler(M, M.name, key)
end
---Prevent modification of module properties by accident
M.__newindex = function(self, key, value)
  Shared.module_setters_handler(self, M.name, key, value)
end
---Prevent access to the module metatable
M.__metatable = false
---Assign the metatable to the module
M = setmetatable(M, M)
---Module is ready here. Additional module operations can be added if needed.
return M
