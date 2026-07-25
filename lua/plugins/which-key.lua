return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>f", group = "Find" },
      { "<leader>c", group = "Code" },
      { "<leader>x", group = "Diagnostics" },
      { "<leader>r", group = "Rust" },
      { "<leader>rc", group = "Cargo" },
      { "<leader>t", group = "Terminal" },
      { "<leader>g", group = "Git" },
    },
  },
}
