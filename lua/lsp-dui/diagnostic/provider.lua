local Shared = require "lsp-dui.shared"

---@class LDProviderModule
local M = {}

---@class LDProvider
local C = { name = "LDProvider" }
C.__index = C
C.__newindex = function(self, key, value)
  Shared.bad_assignment_handler(self, self.name, key, value)
end
C.__metatable = false

function C.new()
  local o = setmetatable({}, C)
  return o
end

M.LDProvider = C
return M
