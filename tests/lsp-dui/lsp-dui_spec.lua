-- lsp-dui_spec.lua
local plugin = require "lsp-dui"

describe("setup", function()
  it("works with default", function()
    plugin.setup {}
    assert(plugin.app:get_opts().order == "category", "my first function with order = lines!")
  end)

  it("works with custom var", function()
    plugin.setup { order = "lines" }
    assert(plugin.app:get_opts().order == "lines", "my first function with order = lines")
  end)
end)
