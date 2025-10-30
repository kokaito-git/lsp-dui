-- Nota: El setup() no se invoca automáticamente en los tests, lo cuál te permite invocar su setup como creas conveniente.
--       Si no lo haces no hay problema, al tratar de acceder a la api se inicializará automáticamente.
-- Modulo principal del plugin, ofrece api, setup, version, name.
local plugin = require "lsp-dui"
--- Inicializará implícitamente la aplicación (plugin.setup() se puede reutilizar pero si lo invocas se
--- borrará el estado actual)
-- local api = plugin.api

--- Obtener _app desde la api no cambia el estado de la aplicación.
--- La puedes usar para probar sin crear una función en la api que invoque a una función de la app ...
-- local app = api._app

describe("setup", function()
  it("working test", function() end)
  local app = plugin._app
  vim.notify("Valor de _app en test: " .. vim.inspect(app), vim.log.levels.DEBUG)
end)
