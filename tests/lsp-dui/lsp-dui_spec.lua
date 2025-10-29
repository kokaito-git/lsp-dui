-- lsp-dui_spec.lua
local plugin = require("lsp-dui")
local api = plugin.api

describe("setup", function()
  it("works with default opts.order (`category`)", function()
    assert(api.opts().default_order == "category", "my first function with order = lines!")
  end)

  it("works with opts.order == `lines`", function()
    ---@class LDPluginOpts
    local settings = { default_order = "lines" }
    plugin.setup(settings)
    assert(api.opts().default_order == "lines", "my first function with order = lines")
  end)

  it("just request window", function()
    api.request_window()
  end)
end)
