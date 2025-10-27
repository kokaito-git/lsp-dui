-- main module file
local App = require "lsp-dui.app"

---@class DuiAppModule
local M = {}

---@param opts DuiAppEntryOpts?
M.setup = function(opts)
  M.app = App:new(opts)
  M.app:start()
end

-- Metatable. Si no se definen opts = ... entonces setup() no es invocado automáticamente
-- por este motivo hacemos que al tratar de acceder a M.app se invoque setup() si es que
-- M.app no existe aún.
setmetatable(M, {
  __index = function(table, key)
    if key == "app" and not rawget(table, "app") then
      M.setup() -- Crea M.app con opciones por defecto
    end
    return rawget(table, key)
  end,
})

return M
