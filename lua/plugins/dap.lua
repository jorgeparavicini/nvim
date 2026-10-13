-- Debugging. nvim-dap is the client, nvim-dap-ui the panels. Rust sessions
-- are started through rustaceanvim (<leader>rD picks a debug target), which
-- finds the Mason-installed codelldb adapter automatically.

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        keys = {
          {
            "<leader>du",
            function()
              require("dapui").toggle({})
            end,
            desc = "Toggle debug UI",
          },
          {
            "<leader>de",
            function()
              require("dapui").eval()
            end,
            desc = "Evaluate expression",
            mode = { "n", "x" },
          },
        },
        opts = {},
        config = function(_, opts)
          local dap, dapui = require("dap"), require("dapui")
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
          end
        end,
      },
    },
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint",
      },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Conditional breakpoint",
      },
      {
        "<leader>dL",
        function()
          require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
        end,
        desc = "Log point",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue / start",
      },
      {
        "<leader>dC",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to cursor",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_out()
        end,
        desc = "Step out",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_over()
        end,
        desc = "Step over",
      },
      {
        "<leader>dp",
        function()
          require("dap").pause()
        end,
        desc = "Pause",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run last",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Toggle REPL",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<leader>dj",
        function()
          require("dap").down()
        end,
        desc = "Down the stack",
      },
      {
        "<leader>dk",
        function()
          require("dap").up()
        end,
        desc = "Up the stack",
      },
      {
        "<leader>dh",
        function()
          require("dap.ui.widgets").hover()
        end,
        desc = "Hover variable",
        mode = { "n", "x" },
      },
      {
        "<leader>ds",
        function()
          local w = require("dap.ui.widgets")
          w.centered_float(w.scopes)
        end,
        desc = "Scopes",
      },
      {
        "<leader>dX",
        function()
          require("dap").clear_breakpoints()
        end,
        desc = "Clear all breakpoints",
      },
      -- Function keys for when you're mid-session and want one hand on the keyboard.
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Debug: continue",
      },
      {
        "<F9>",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Debug: toggle breakpoint",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Debug: step over",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Debug: step into",
      },
      {
        "<F12>",
        function()
          require("dap").step_out()
        end,
        desc = "Debug: step out",
      },
    },
    config = function()
      local signs = {
        DapBreakpoint = { "\u{F111}", "DiagnosticError" }, --
        DapBreakpointCondition = { "\u{F111}", "DiagnosticWarn" },
        DapLogPoint = { "\u{F0E0}", "DiagnosticInfo" }, --
        DapBreakpointRejected = { "\u{F111}", "DiagnosticHint" },
        DapStopped = { "\u{F0A4}", "DiagnosticWarn", "DapStoppedLine" }, --
      }
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
      for name, s in pairs(signs) do
        vim.fn.sign_define(name, { text = s[1], texthl = s[2], linehl = s[3], numhl = s[3] })
      end
    end,
  },
}
