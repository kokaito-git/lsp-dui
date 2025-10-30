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
  local o = setmetatable({}, C)
  return o
end

--- --------------------------------------------------------------
--- Metatable adjustments
--- --------------------------------------------------------------

---Metatable to control class property access
C.__index = C
---Prevent modification of class properties by accident
C.__newindex = function(self, key, value)
  Shared.bad_assignment_handler(self, self.name, key, value)
end
---Prevent access to the class metatable
C.__metatable = false
---Assign the class to the module
M.LDService = C
---Class is ready here. Additional operations can be added if needed.
---Module is ready here. Additional module operations can be added if needed.
return M
