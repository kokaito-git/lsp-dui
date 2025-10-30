local Shared = require "lsp-dui.shared"

--- --------------------------------------------------------------
--- Module Definition
--- --------------------------------------------------------------

---Module for LDService class
---@class LDServiceModule
local M = { name = "LDServiceModule" }

--- --------------------------------------------------------------
--- Class Definition
--- --------------------------------------------------------------

---TODO: Document the LDService class
---@class LDService
local C = { name = "LDService" }

--- --------------------------------------------------------------
--- Public Class Methods
--- --------------------------------------------------------------

---TODO: Document the constructor
function C.new()
  ---@class LDService
  local o = setmetatable({}, C)
  return o
end

--- --------------------------------------------------------------
--- Class Metatable adjustments
--- --------------------------------------------------------------

---Metatable to control class property access
C.__index = C
---Prevent modification of class properties by accident
C.__newindex = function(self, key, value)
  Shared.bad_assignment_handler(self, C.name, key, value)
end
---Prevent access to the class metatable
C.__metatable = false

---Assign the class to the module (*)
M.LDService = C

--- --------------------------------------------------------------
--- Module Metatable adjustments
--- --------------------------------------------------------------

---Metatable to control module property access
M.__index = M
---Prevent modification of module properties by accident
M.__newindex = function(self, key, value)
  Shared.bad_assignment_handler(self, M.name, key, value)
end
---Prevent access to the module metatable
M.__metatable = false
---Assign the module metatable
M = setmetatable(M, M)
return M
