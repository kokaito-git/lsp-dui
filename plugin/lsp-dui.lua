vim.api.nvim_create_user_command("Df", function()
  require("lsp-dui").api.request_window()
end, {})
