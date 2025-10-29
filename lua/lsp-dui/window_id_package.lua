-- window_id_package.lua
local Shared = require "lsp-dui.shared"

---@class LDWindowIdPkg
local LDWindowIDPackage = { name = "LDWindowIDPackage" }
-- Metatable to protect read-only properties
LDWindowIDPackage.__index = LDWindowIDPackage
-- Prevent modification of properties by accident
LDWindowIDPackage.__newindex = function(self, key, value)
  Shared.bad_assignment_handler(self, self.name, key, value)
end
-- Prevent access to the metatable
LDWindowIDPackage.__metatable = false

function LDWindowIDPackage.new(orig_buf, orig_win, buf, win)
  ---@class LDWindowIdPkg
  local o = setmetatable({}, LDWindowIDPackage)
  o._orig_buf = orig_buf
  o._orig_win = orig_win
  o._buf = buf
  o._win = win
  return o
end

function LDWindowIDPackage:orig_buf()
  return self._orig_buf
end

function LDWindowIDPackage:orig_win()
  return self._orig_win
end

function LDWindowIDPackage:buf()
  return self._buf
end

function LDWindowIDPackage:win()
  return self._win
end

return LDWindowIDPackage
