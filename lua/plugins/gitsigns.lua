-- Git signs in the gutter + hunk operations under <leader>gh.
-- Repo-level git (lazygit, log, status, branches) is in snacks.lua under <leader>g.

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "▁" },
      topdelete = { text = "▔" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    signs_staged = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "▁" },
      topdelete = { text = "▔" },
      changedelete = { text = "▎" },
    },
    on_attach = function(bufnr)
      local gs = require("gitsigns")
      local map = function(mode, keys, fn, desc)
        vim.keymap.set(mode, keys, fn, { buffer = bufnr, desc = desc })
      end

      -- Navigation
      map("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gs.nav_hunk("next")
        end
      end, "Next hunk")
      map("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gs.nav_hunk("prev")
        end
      end, "Prev hunk")
      map("n", "]H", function()
        gs.nav_hunk("last")
      end, "Last hunk")
      map("n", "[H", function()
        gs.nav_hunk("first")
      end, "First hunk")

      -- Hunk actions
      map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage hunk")
      map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset hunk")
      map("n", "<leader>ghS", gs.stage_buffer, "Stage buffer")
      map("n", "<leader>ghR", gs.reset_buffer, "Reset buffer")
      map("n", "<leader>ghu", gs.stage_hunk, "Undo stage hunk (toggle)")
      map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview hunk inline")
      map("n", "<leader>ghP", gs.preview_hunk, "Preview hunk (popup)")
      map("n", "<leader>ghb", function()
        gs.blame_line({ full = true })
      end, "Blame line")
      map("n", "<leader>ghB", gs.blame, "Blame buffer")
      map("n", "<leader>ghd", gs.diffthis, "Diff this")
      map("n", "<leader>ghD", function()
        gs.diffthis("~")
      end, "Diff this ~")
      map("n", "<leader>ght", gs.toggle_current_line_blame, "Toggle line blame")

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
    end,
  },
}
