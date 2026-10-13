-- Formatting. Format on save unless vim.g.autoformat (toggle: <leader>uf)
-- or vim.b.autoformat is false. Formatters come from mason (stylua, ruff)
-- or PATH (rustfmt, taplo).

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt", lsp_format = "fallback" },
      python = { "ruff_organize_imports", "ruff_format" },
      toml = { "taplo" },
      yaml = { lsp_format = "prefer" },
      json = { lsp_format = "prefer" },
      cs = { lsp_format = "prefer" },
    },
    format_on_save = function(bufnr)
      if not vim.g.autoformat or vim.b[bufnr].autoformat == false then
        return
      end
      return { timeout_ms = 500, lsp_format = "fallback" }
    end,
  },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = { "n", "x" },
      desc = "Format buffer / selection",
    },
    { "<leader>cF", "<cmd>ConformInfo<cr>", desc = "Formatter info" },
  },
}
