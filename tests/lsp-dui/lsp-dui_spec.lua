-- lsp-dui_spec.lua
local plugin = require "lsp-dui"

describe("setup", function()
  it("works with default opts.order (`category`)", function()
    plugin.setup {}
    assert(plugin.app:get_opts().order == "category", "my first function with order = lines!")
  end)

  it("works with opts.order == `lines`", function()
    plugin.setup { order = "lines" }
    assert(plugin.app:get_opts().order == "lines", "my first function with order = lines")
  end)
end)

