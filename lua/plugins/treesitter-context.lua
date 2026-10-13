-- Sticky header showing the enclosing function/class while scrolling.

return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "VeryLazy",
  opts = { mode = "cursor", max_lines = 3 },
  keys = {
    {
      "<leader>ut",
      function()
        local tsc = require("treesitter-context")
        tsc.toggle()
        Snacks.notify((tsc.enabled() and "Enabled" or "Disabled") .. " Treesitter Context")
      end,
      desc = "Toggle Treesitter Context",
    },
  },
}
