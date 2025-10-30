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
M.__index = M
---Prevent modification of module properties by accident
M.__newindex = function(self, key, value)
  Shared.bad_assignment_handler(self, self.name, key, value)
end
---Prevent access to the module metatable
M.__metatable = false
---Assign the module metatable
M = setmetatable(M, M)
return M
