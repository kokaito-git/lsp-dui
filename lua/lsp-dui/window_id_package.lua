-- window_id_package.lua
local Shared = require "lsp-dui.shared"

---@class WindowIdPkg
local WindowIDPackage = { name = "WindowIDPackage" }
-- Metatable to protect read-only properties
WindowIDPackage.__index = WindowIDPackage
-- Prevent modification of properties by accident
WindowIDPackage.__newindex = function(self, key, value)
  Shared.bad_assignment_handler(self, self.name, key, value)
end
-- Prevent access to the metatable
WindowIDPackage.__metatable = false

function WindowIDPackage.new(orig_buf, orig_win, buf, win)
  ---@class WindowIdPkg
  local o = setmetatable({}, WindowIDPackage)
  o._orig_buf = orig_buf
  o._orig_win = orig_win
  o._buf = buf
  o._win = win
  return o
end

function WindowIDPackage:orig_buf()
  return self._orig_buf
end

function WindowIDPackage:orig_win()
  return self._orig_win
end

function WindowIDPackage:buf()
  return self._buf
end

function WindowIDPackage:win()
  return self._win
end

return WindowIDPackage
