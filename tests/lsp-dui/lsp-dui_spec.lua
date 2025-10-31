describe("setup", function()
  it("working test", function()
    local plugin = require "lsp-dui"
    local api = plugin.api
    api.setup()

    vim.notify("Is app running?: " .. tostring(api.is_running))
    vim.notify("Current version: " .. api.version)
    vim.notify("Current opts: " .. vim.inspect(api.opts))
  end)
end)
