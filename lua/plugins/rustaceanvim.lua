return {
  "mrcjkb/rustaceanvim",
  version = "^9",
  lazy = false,
  init = function()
    vim.g.rustaceanvim = {
      server = {
        on_attach = function(_, bufnr)
          local map = function(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = "Rust: " .. desc })
          end
          map("<leader>rr", function()
            vim.cmd.RustLsp("runnables")
          end, "Runnables")
          map("<leader>rt", function()
            vim.cmd.RustLsp("testables")
          end, "Testables")
          map("<leader>rd", function()
            vim.cmd.RustLsp("renderDiagnostic")
          end, "Render diagnostic")
          map("<leader>re", function()
            vim.cmd.RustLsp("explainError")
          end, "Explain error")
          map("<leader>rm", function()
            vim.cmd.RustLsp("expandMacro")
          end, "Expand macro")
          map("K", function()
            vim.cmd.RustLsp({ "hover", "actions" })
          end, "Hover actions")
        end,
        default_settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            check = { command = "clippy" },
          },
        },
      },
    }
  end,
}
