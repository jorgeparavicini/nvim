-- Diagnostic display. Virtual text by default; <leader>uv switches to
-- virtual lines (full-width message under the cursor line).

vim.diagnostic.config({
  virtual_text = { prefix = "●", source = "if_many", spacing = 2 },
  virtual_lines = false,
  severity_sort = true,
  underline = true,
  update_in_insert = false,
  float = { border = "rounded", source = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },
})
