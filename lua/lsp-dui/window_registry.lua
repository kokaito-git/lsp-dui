local Shared = require "lsp-dui.shared"
local Window = require "lsp-dui.window"

---@class LDWindowRegistry
local LDWindowRegistry = { name = "LDWindowRegistry" }
LDWindowRegistry.__index = LDWindowRegistry
-- Prevent modification of properties by accident
LDWindowRegistry.__newindex = function(self, key, value)
  Shared.bad_assignment_handler(self, self.name, key, value)
end
-- Prevent access to the metatable
LDWindowRegistry.__metatable = false

function LDWindowRegistry.new(opts)
  ---@class LDWindowRegistry
  local o = setmetatable({}, LDWindowRegistry)

  -- Contiene un mapa de orig_buf
  ---@type table<number, LDWindow>
  o._registry = {}

  return o
end

function LDWindowRegistry:has(orig_buf)
  return self._registry[orig_buf] ~= nil
end

function LDWindowRegistry:get(orig_buf)
  return self._registry[orig_buf]
end

function LDWindowRegistry:register(window)
  local orig_buf = window:orig_buf()
  if self:has(orig_buf) then
    error("Window already registered for orig_buf: " .. orig_buf)
  end
  self._registry[orig_buf] = window
end

function LDWindowRegistry:unregister(orig_buf)
  self._registry[orig_buf] = nil
end

function LDWindowRegistry:clear()
  self._registry = {}
end

return LDWindowRegistry
