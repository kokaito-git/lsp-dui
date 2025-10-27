-- lsp-dui_spec.lua
local plugin = require "lsp-dui"

---@type fun(desc: string, fn: fun())
local describe
---@type fun(desc: string, fn: fun())
local it

describe("setup", function()
  it("works with default", function()
    plugin.setup {}
    assert(plugin.app:test() == "Hello!", "my first function with param = Hello!")
  end)

  it("works with custom var", function()
    plugin.setup { order = "category" }
    assert(plugin.app:test() == "custom", "my first function with param = custom")
  end)
end)
