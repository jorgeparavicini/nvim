return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp",
  },
  config = function()
    vim.lsp.config("lua_ls", {
      settings = { Lua = { diagnostics = { globals = { "vim" } } } },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local map = function(keys, fn, desc)
          vim.keymap.set("n", keys, fn, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        map("gd", function()
          Snacks.picker.lsp_definitions()
        end, "Go to definition")
        map("gr", function()
          Snacks.picker.lsp_references()
        end, "Go to references")
        map("<leader>cr", vim.lsp.buf.rename, "Rename symbol")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
      end,
    })

    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "rust_analyzer" },
    })
  end,
}
