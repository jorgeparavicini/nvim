return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    delay = 300,
    spec = {
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Debug" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>gh", group = "Hunks" },
      { "<leader>q", group = "Quit" },
      { "<leader>r", group = "Rust / Cargo" },
      { "<leader>rc", group = "Cargo" },
      { "<leader>s", group = "Search" },
      { "<leader>t", group = "Test" },
      { "<leader>u", group = "UI toggles" },
      { "<leader>w", group = "Window" },
      { "<leader>x", group = "Diagnostics" },
      { "g", group = "Goto" },
      { "gs", group = "Surround" },
      { "z", group = "Fold" },
      { "[", group = "Prev" },
      { "]", group = "Next" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer-local keymaps",
    },
  },
}
