local Shared = require "lsp-dui.shared"

--- --------------------------------------------------------------
--- Module Definition
--- --------------------------------------------------------------

---Module for LDProblem class
---@class LDProblemModule
local M = { name = "LDProblemModule" }

--- --------------------------------------------------------------
--- Class Definition
--- --------------------------------------------------------------

---TODO: Documentar la clase LDProblem
---@class LDProblem
local C = { name = "LDProblem" }

--- --------------------------------------------------------------
--- Public Class Methods
--- --------------------------------------------------------------

function C.new()
  ---@class LDProblem
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
  Shared.bad_assignment_handler(self, self.name, key, value)
end
---Prevent access to the class metatable
C.__metatable = false

---Assign the class to the module (*)
M.LDProblem = C

--- --------------------------------------------------------------
--- Module Metatable adjustments
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
---Module is ready here. Additional module operations can be added if needed.
return M
