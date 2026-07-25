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
        -- gd/grr override Neovim's built-ins with Snacks' nicer picker UI.
        -- Rename (grn), code action (gra) and hover (K) are already provided
        -- by Neovim 0.11+ default LSP mappings, so we don't remap them here.
        map("gd", function()
          Snacks.picker.lsp_definitions()
        end, "Go to definition")
        map("grr", function()
          Snacks.picker.lsp_references()
        end, "Go to references")
        map("<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
      end,
    })

    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls" },
      automatic_enable = { exclude = { "rust_analyzer" } },
    })
  end,
}
