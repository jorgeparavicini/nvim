-- Diff viewer with a file tree: whole-branch diffs against the base branch,
-- and file / line history. Buffers are real files, so LSP works in them.

local function base_branch()
  local out = vim.fn.systemlist("git symbolic-ref --quiet --short refs/remotes/origin/HEAD")
  if vim.v.shell_error == 0 and out[1] and out[1] ~= "" then
    return out[1] -- e.g. origin/main
  end
  for _, b in ipairs({ "origin/main", "origin/master", "main", "master" }) do
    vim.fn.system("git rev-parse --verify --quiet " .. b)
    if vim.v.shell_error == 0 then
      return b
    end
  end
  return "HEAD~1"
end

return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = { layout = "diff2_horizontal", winbar_info = true },
      merge_tool = { layout = "diff3_mixed", disable_diagnostics = true },
      file_history = { layout = "diff2_horizontal", winbar_info = true },
    },
    file_panel = { win_config = { width = 38 } },
    keymaps = {
      view = { { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } } },
      file_panel = { { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } } },
      file_history_panel = { { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } } },
    },
  },
  keys = {
    {
      "<leader>gD",
      function()
        local lib = require("diffview.lib")
        if lib.get_current_view() then
          vim.cmd("DiffviewClose")
        else
          vim.cmd("DiffviewOpen " .. base_branch() .. "...HEAD --imply-local")
        end
      end,
      desc = "Diff branch vs base (toggle)",
    },
    { "<leader>gw", "<cmd>DiffviewOpen<cr>", desc = "Diff working tree" },
    { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "File history (current file)" },
    { "<leader>gH", "<cmd>'<,'>DiffviewFileHistory<cr>", mode = "x", desc = "History of selection" },
    { "<leader>gC", "<cmd>DiffviewFileHistory<cr>", desc = "Commit history (repo)" },
  },
}
