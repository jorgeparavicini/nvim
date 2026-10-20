-- Rust: rust-analyzer via rustaceanvim (not mason-lspconfig).
--
-- Keymaps are registered on FileType rust, not on LSP attach, so <leader>r
-- is populated the moment a .rs file opens even while rust-analyzer is still
-- indexing a large workspace. Commands that need the server tell you so.
--
--   <leader>r   rust-analyzer actions (runnables, debug, macros, docs, ...)
--   <leader>T   tests via neotest (see neotest.lua)
--   Cargo.toml  crates.nvim keys under <leader>r (see crates.lua)

return {
  "mrcjkb/rustaceanvim",
  version = "^9",
  lazy = false,
  init = function()
    vim.g.rustaceanvim = {
      tools = {
        -- Run tests through neotest so results show inline (see neotest.lua).
        test_executor = "neotest",
        crate_test_executor = "neotest",
        float_win_config = { border = "rounded" },
      },
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = { enable = true },
            },
            checkOnSave = true,
            check = { command = "clippy", extraArgs = { "--no-deps" } },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
            files = { excludeDirs = { ".direnv", ".git", "target" } },
            inlayHints = {
              bindingModeHints = { enable = false },
              chainingHints = { enable = true },
              closingBraceHints = { enable = true, minLines = 25 },
              closureReturnTypeHints = { enable = "always" },
              lifetimeElisionHints = { enable = "skip_trivial", useParameterNames = true },
              parameterHints = { enable = true },
              typeHints = { enable = true },
            },
            lens = { enable = true, references = { adt = { enable = true }, method = { enable = true } } },
          },
        },
      },
    }

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("jorge_rust_keys", { clear = true }),
      pattern = "rust",
      callback = function(ev)
        local function rust(cmd, desc, mode)
          vim.keymap.set(mode or "n", cmd[1], function()
            vim.cmd.RustLsp(cmd[2])
          end, { buffer = ev.buf, desc = desc })
        end

        -- Overrides of generic LSP keys with the Rust-aware versions.
        rust({ "<leader>ca", "codeAction" }, "Code action (grouped)", { "n", "x" })
        rust({ "K", { "hover", "actions" } }, "Hover + actions")
        rust({ "<leader>K", { "hover", "range" } }, "Hover range", { "x" })

        -- Run / debug / test
        rust({ "<leader>rr", "runnables" }, "Runnables (pick & run)")
        rust({ "<leader>rR", { "runnables", "last" } }, "Rerun last runnable")
        rust({ "<leader>rD", "debuggables" }, "Debuggables (pick & debug)")
        rust({ "<leader>rL", { "debuggables", "last" } }, "Redebug last debuggable")
        rust({ "<leader>rt", "testables" }, "Testables (pick & test)")

        -- Diagnostics / errors
        rust({ "<leader>re", "explainError" }, "Explain error (rustc --explain)")
        rust({ "<leader>rd", "renderDiagnostic" }, "Render diagnostic (cargo style)")
        rust({ "<leader>rE", "relatedDiagnostics" }, "Related diagnostics")
        rust({ "<leader>rf", { "flyCheck", "run" } }, "Fly check (cargo check now)")
        rust({ "<leader>rF", { "flyCheck", "clear" } }, "Clear fly check diagnostics")

        -- Code
        rust({ "<leader>rm", "expandMacro" }, "Expand macro (recursive)")
        rust({ "<leader>rM", "rebuildProcMacros" }, "Rebuild proc macros")
        rust({ "<leader>rj", "joinLines" }, "Join lines (Rust-aware)")
        rust({ "<leader>rs", "ssr" }, "Structural search & replace")
        rust({ "<leader>rk", { "moveItem", "up" } }, "Move item up")
        rust({ "<leader>rJ", { "moveItem", "down" } }, "Move item down")

        -- Navigation
        rust({ "<leader>ro", "openCargo" }, "Open Cargo.toml")
        rust({ "<leader>rO", "openDocs" }, "Open docs.rs for symbol")
        rust({ "<leader>rp", "parentModule" }, "Go to parent module")
        rust({ "<leader>rw", "workspaceSymbol" }, "Workspace symbols (rust-analyzer)")

        -- Inspect
        rust({ "<leader>rg", { "crateGraph", "svg" } }, "Crate graph (svg)")
        rust({ "<leader>rS", "syntaxTree" }, "View syntax tree")
        rust({ "<leader>rh", { "view", "hir" } }, "View HIR")
        rust({ "<leader>ri", { "view", "mir" } }, "View MIR")
        rust({ "<leader>rl", "logFile" }, "Open rust-analyzer log")

        -- Server control
        vim.keymap.set(
          "n",
          "<leader>rx",
          "<cmd>RustAnalyzer restart<cr>",
          { buffer = ev.buf, desc = "Restart rust-analyzer" }
        )
        vim.keymap.set(
          "n",
          "<leader>rX",
          "<cmd>RustAnalyzer reloadSettings<cr>",
          { buffer = ev.buf, desc = "Reload rust-analyzer settings" }
        )
      end,
    })
  end,
}
