return {
  "folke/todo-comments.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
  keys = {
    {
      "<leader>ft",
      function()
        require("todo-comments")
        Snacks.picker.pick("todo_comments")
      end,
      desc = "Search Todos",
    },
  },
}
