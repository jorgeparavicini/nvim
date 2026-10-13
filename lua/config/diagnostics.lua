-- Diagnostic display. Virtual lines (full-width message under the cursor
-- line) by default; <leader>uv switches to inline virtual text for the session.

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = { current_line = true },
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
