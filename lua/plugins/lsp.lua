-- LSP servers via mason + nvim-lspconfig. Rust is handled by rustaceanvim.
-- blink.cmp registers its completion capabilities on vim.lsp.config("*") by itself.

return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = {
        ui = { border = "rounded" },
        -- Crashdummyy registry ships the Roslyn C# server at the VS Code version.
        registries = { "github:mason-org/mason-registry", "github:Crashdummyy/mason-registry" },
      },
    },
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp",
    "b0o/SchemaStore.nvim",
  },
  config = function()
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          hint = { enable = true },
          completion = { callSnippet = "Replace" },
        },
      },
    })

    vim.lsp.config("yamlls", {
      settings = {
        yaml = {
          -- SchemaStore.nvim ships the catalog, so the server's own fetching is off.
          schemaStore = { enable = false, url = "" },
          schemas = require("schemastore").yaml.schemas(),
          -- Complains about alphabetically unordered keys otherwise.
          keyOrdering = false,
          format = { enable = true },
          validate = true,
        },
      },
    })

    vim.lsp.config("jsonls", {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })

    vim.lsp.config("basedpyright", {
      settings = {
        basedpyright = {
          analysis = { typeCheckingMode = "standard", inlayHints = { callArgumentNames = true } },
        },
      },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("jorge_lsp_attach", { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local map = function(keys, fn, desc, mode)
          vim.keymap.set(mode or "n", keys, fn, { buffer = event.buf, desc = desc })
        end

        -- Goto (Neovim's own defaults are grn/gra/grr/gri/grt; the g* ones
        -- below use Snacks pickers so you can preview before jumping).
        map("gd", function()
          Snacks.picker.lsp_definitions()
        end, "Goto definition")
        map("gD", function()
          Snacks.picker.lsp_declarations()
        end, "Goto declaration")
        map("gI", function()
          Snacks.picker.lsp_implementations()
        end, "Goto implementation")
        map("gy", function()
          Snacks.picker.lsp_type_definitions()
        end, "Goto type definition")
        map("grr", function()
          Snacks.picker.lsp_references()
        end, "References", { "n" })
        map("gK", vim.lsp.buf.signature_help, "Signature help")
        map("<C-k>", vim.lsp.buf.signature_help, "Signature help", "i")

        -- Code
        map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "x" })
        map("<leader>cr", vim.lsp.buf.rename, "Rename symbol")
        map("<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
        map("<leader>cl", "<cmd>checkhealth vim.lsp<cr>", "LSP info")
        map("<leader>cm", "<cmd>Mason<cr>", "Mason")
        map("<leader>cA", function()
          vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } })
        end, "Source action")
        map("<leader>cq", function()
          vim.lsp.buf.code_action({ context = { only = { "quickfix" } }, apply = true })
        end, "Apply quick fix (no menu if only one)")
        map("<leader>cD", function()
          local line = vim.api.nvim_win_get_cursor(0)[1] - 1
          for _, d in ipairs(vim.diagnostic.get(0, { lnum = line })) do
            local lsp = d.user_data and d.user_data.lsp
            local href = lsp and lsp.codeDescription and lsp.codeDescription.href
            if href then
              vim.ui.open(href)
              return
            end
          end
          vim.notify("No diagnostic with documentation link on this line", vim.log.levels.WARN)
        end, "Open diagnostic documentation")

        if client and client:supports_method("textDocument/inlayHint") then
          vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
        end
      end,
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "yamlls",
        "jsonls",
        "taplo", -- TOML (Cargo.toml etc.)
        "basedpyright", -- Python types
        "ruff", -- Python lint + format
        "marksman", -- Markdown links, headings, diagnostics
      },
      automatic_enable = { exclude = { "rust_analyzer" } },
    })
  end,
}
