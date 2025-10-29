local Shared = require "lsp-dui.shared"

---@class LDProblemModule
local M = {}

---@class LDProblem
local C = { name = "LDProblem" }
C.__index = C
C.__newindex = function(self, key, value)
  Shared.bad_assignment_handler(self, self.name, key, value)
end
C.__metatable = false

function C.new()
  local o = setmetatable({}, C)
  return o
end

M.LDProblem = C
return M
