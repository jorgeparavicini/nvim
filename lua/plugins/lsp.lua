return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp",
  },
  config = function()
    vim.diagnostic.config({
      virtual_lines = { current_line = true },
      underline = true,
      severity_sort = true,
    })

    vim.lsp.config("lua_ls", {
      settings = { Lua = { diagnostics = { globals = { "vim" } } } },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local map = function(keys, fn, desc)
          vim.keymap.set("n", keys, fn, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        -- gd / gr are provided by snacks.nvim (picker-based, better in big repos).
        map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action")
        -- <leader>e is the snacks explorer, so diagnostics-float lives on <leader>cd.
        map("<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
      end,
    })

    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "rust_analyzer" },
    })
  end,
}
