vim.diagnostic.config({
  virtual_text = { prefix = "●", source = "if_many" },
  severity_sort = true,
  float = { border = "rounded", source = true },
  underline = true,
  virtual_lines = { current_line = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },
})

vim.keymap.set("n", "<leader>xl", function()
  local cfg = vim.diagnostic.config()
  if not cfg or cfg.virtual_lines == true then
    vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = { prefix = "●" } })
  else
    vim.diagnostic.config({ virtual_lines = true, virtual_text = false })
  end
end, { desc = "Toggle diagnostic virtual lines" })
