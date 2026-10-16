-- GitHub PR review inside Neovim (octo.nvim, driven by the gh CLI).
--
-- Flow:  <leader>gp  pick a PR  ->  Enter opens it as a buffer
--        <leader>gr  start (or resume) a review: file panel + diff
--        <space>ca   comment on the line / selection,  <space>sa  suggestion
--        ]q / [q     next / prev changed file,  ]t / [t  next / prev thread
--        <space>vs   submit: Ctrl-a approve, Ctrl-r request changes, Ctrl-m comment
--
-- <localleader> is <space>, so octo's own maps show up under <space> in
-- review buffers and nowhere else. Pending comments are saved on GitHub as
-- a draft review, so you can quit and resume later.

return {
  "pwntester/octo.nvim",
  cmd = "Octo",
  dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim" },
  opts = {
    picker = "snacks",
    enable_builtin = true, -- bare :Octo opens a picker of commands
    default_merge_method = "squash",
    reviews = {
      auto_show_threads = true,
      focus = "right",
      show_virtual_text = true,
    },
    file_panel = { size = 12, icons = true },
    pull_requests = {
      order_by = { field = "UPDATED_AT", direction = "DESC" },
    },
  },
  keys = {
    { "<leader>gp", "<cmd>Octo pr list<cr>", desc = "Pull requests (open)" },
    { "<leader>gP", "<cmd>Octo pr search is:open review-requested:@me<cr>", desc = "PRs awaiting my review" },
    { "<leader>gi", "<cmd>Octo issue list<cr>", desc = "Issues" },
    {
      "<leader>gr",
      function()
        require("octo.reviews").start_or_resume_review()
      end,
      desc = "Review: start or resume",
    },
    { "<leader>gR", "<cmd>Octo review submit<cr>", desc = "Review: submit" },
    { "<leader>gn", "<cmd>Octo notification list<cr>", desc = "GitHub notifications" },
    { "<leader>gO", "<cmd>Octo<cr>", desc = "Octo commands" },
  },
}
