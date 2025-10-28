-- window_id_package.lua
local Shared = require "lsp-dui.shared"

---@class WindowIDPackage
local WindowIDPackage = { name = "WindowIDPackage" }
-- Metatable to protect read-only properties
WindowIDPackage.__index = function(self, key)
  if key == "buf" then
    return self._buf
  elseif key == "win" then
    return self._win
  elseif key == "orig_buf" then
    return self._orig_buf
  elseif key == "orig_win" then
    return self._orig_win
  else
    return WindowIDPackage[key]
  end
end
-- Prevent modification of properties by accident
WindowIDPackage.__newindex = function(self, key, value)
  Shared.bad_assignment_handler(self, self.name, key, value)
end
-- Prevent access to the metatable
WindowIDPackage.__metatable = false

function WindowIDPackage.new(orig_buf, orig_win, buf, win)
  ---@class WindowIDPackage
  local o = setmetatable({}, WindowIDPackage)
  o._orig_buf = orig_buf
  o._orig_win = orig_win
  o._buf = buf
  o._win = win
  return o
end

return WindowIDPackage
