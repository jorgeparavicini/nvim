-- Test runner UI. Rust tests come from rustaceanvim's neotest adapter.
-- Pass/fail shows as signs + virtual text next to each test; output and a
-- summary tree are a key away.

return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "mrcjkb/rustaceanvim",
  },
  opts = function()
    return {
      adapters = { require("rustaceanvim.neotest") },
      status = { virtual_text = true },
      output = { open_on_run = true },
      quickfix = {
        open = function()
          require("trouble").open({ mode = "quickfix", focus = false })
        end,
      },
    }
  end,
  keys = {
    {
      "<leader>Tt",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run file",
    },
    {
      "<leader>TT",
      function()
        require("neotest").run.run(vim.uv.cwd())
      end,
      desc = "Run all (cwd)",
    },
    {
      "<leader>Tr",
      function()
        require("neotest").run.run()
      end,
      desc = "Run nearest",
    },
    {
      "<leader>Tl",
      function()
        require("neotest").run.run_last()
      end,
      desc = "Run last",
    },
    {
      "<leader>Td",
      function()
        require("neotest").run.run({ strategy = "dap" })
      end,
      desc = "Debug nearest",
    },
    {
      "<leader>Ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle summary",
    },
    {
      "<leader>To",
      function()
        require("neotest").output.open({ enter = true, auto_close = true })
      end,
      desc = "Show output",
    },
    {
      "<leader>TO",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Toggle output panel",
    },
    {
      "<leader>TS",
      function()
        require("neotest").run.stop()
      end,
      desc = "Stop",
    },
    {
      "<leader>Tw",
      function()
        require("neotest").watch.toggle(vim.fn.expand("%"))
      end,
      desc = "Toggle watch (file)",
    },
    {
      "]T",
      function()
        require("neotest").jump.next({ status = "failed" })
      end,
      desc = "Next failed test",
    },
    {
      "[T",
      function()
        require("neotest").jump.prev({ status = "failed" })
      end,
      desc = "Prev failed test",
    },
  },
}
