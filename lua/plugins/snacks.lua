return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    explorer = { enabled = true },
    picker = { enabled = true, ui_select = true, sources = { explorer = { auto_close = false } } },
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    indent = { enabled = true },
    scope = { enabled = true },
    words = { enabled = true },
    notifier = { enabled = true },
    input = { enabled = true },
    statuscolumn = { enabled = true },
    scroll = { enabled = true },
    dashboard = { enabled = true },
  },
  keys = {
    {
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = "File Explorer",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep in Project",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Open Buffers",
    },
    {
      "<leader><space>",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find",
    },
  },
}
