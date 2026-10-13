-- Rust: rust-analyzer via rustaceanvim (not mason-lspconfig).
-- Rust keys live under <leader>r, cargo terminals under <leader>rc.

return {
  "mrcjkb/rustaceanvim",
  version = "^9",
  lazy = false,
  keys = {
    {
      "<leader>rcr",
      function()
        Snacks.terminal.toggle(vim.g.cargo_run_cmd or "cargo run", { win = { position = "bottom", height = 0.35 } })
      end,
      desc = "cargo run",
    },
    {
      "<leader>rct",
      function()
        Snacks.terminal.toggle("cargo test", { win = { position = "bottom", height = 0.35 } })
      end,
      desc = "cargo test",
    },
    {
      "<leader>rcc",
      function()
        Snacks.terminal.toggle("cargo check", { win = { position = "bottom", height = 0.35 } })
      end,
      desc = "cargo check",
    },
    {
      "<leader>rcb",
      function()
        Snacks.terminal.toggle("cargo build", { win = { position = "bottom", height = 0.35 } })
      end,
      desc = "cargo build",
    },
    {
      "<leader>rcl",
      function()
        Snacks.terminal.toggle("cargo clippy", { win = { position = "bottom", height = 0.35 } })
      end,
      desc = "cargo clippy",
    },
  },
  init = function()
    vim.g.rustaceanvim = {
      server = {
        on_attach = function(_, bufnr)
          local map = function(keys, fn, desc, mode)
            vim.keymap.set(mode or "n", keys, fn, { buffer = bufnr, desc = desc })
          end
          -- Grouped code actions (better than vim.lsp.buf.code_action for Rust).
          map("<leader>ca", function()
            vim.cmd.RustLsp("codeAction")
          end, "Code action", { "n", "x" })
          map("K", function()
            vim.cmd.RustLsp({ "hover", "actions" })
          end, "Hover actions")

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
          map("<leader>ro", function()
            vim.cmd.RustLsp("openCargo")
          end, "Open Cargo.toml")
          map("<leader>rD", function()
            vim.cmd.RustLsp("openDocs")
          end, "Open docs.rs")
          map("<leader>rp", function()
            vim.cmd.RustLsp("parentModule")
          end, "Parent module")
          map("<leader>rj", function()
            vim.cmd.RustLsp("joinLines")
          end, "Join lines")
          map("<leader>rs", function()
            vim.cmd.RustLsp("ssr")
          end, "Structural search replace")
          map("<leader>rR", function()
            vim.cmd.RustLsp("relatedDiagnostics")
          end, "Related diagnostics")
        end,
        default_settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            check = { command = "clippy" },
            inlayHints = {
              lifetimeElisionHints = { enable = "skip_trivial" },
              closureReturnTypeHints = { enable = "always" },
            },
          },
        },
      },
    }
  end,
}
