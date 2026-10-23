-- Tab-like list of open buffers at the top of the screen.

return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer left" },
    { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer right" },
    { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle pin" },
    { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Delete non-pinned buffers" },
    { "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Delete buffers to the left" },
    { "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Delete buffers to the right" },
    { "<leader>bs", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
  },
  opts = function()
    return {
      -- With a transparent background catppuccin gives active and inactive
      -- tabs the same (no) background, so the current one is invisible.
      -- Give the selected tab a solid surface colour and a blue indicator.
      highlights = require("catppuccin.special.bufferline").get_theme({
        custom = {
          all = (function()
            local C = require("catppuccin.palettes").get_palette()
            local sel = { bg = C.surface1 }
            local names = {
              "buffer",
              "duplicate",
              "modified",
              "close_button",
              "numbers",
              "pick",
              "error",
              "warning",
              "info",
              "hint",
              "error_diagnostic",
              "warning_diagnostic",
              "info_diagnostic",
              "hint_diagnostic",
              "diagnostic",
            }
            local t = {}
            for _, n in ipairs(names) do
              t[n .. "_selected"] = vim.deepcopy(sel)
            end
            t.buffer_selected = { fg = C.text, bg = C.surface1, style = { "bold" } }
            t.indicator_selected = { fg = C.blue, bg = C.surface1, style = { "bold" } }
            t.separator_selected = { fg = C.surface1, bg = "NONE" }
            return t
          end)(),
        },
      }),
      options = {
        close_command = function(n)
          Snacks.bufdelete(n)
        end,
        right_mouse_command = function(n)
          Snacks.bufdelete(n)
        end,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diag)
          local icons = { error = "󰅚 ", warning = "󰀪 " }
          local parts = {}
          if diag.error then
            table.insert(parts, icons.error .. diag.error)
          end
          if diag.warning then
            table.insert(parts, icons.warning .. diag.warning)
          end
          return table.concat(parts, " ")
        end,
        always_show_bufferline = false,
        separator_style = "slant",
        offsets = {
          { filetype = "snacks_layout_box" },
        },
        get_element_icon = function(opts)
          return require("mini.icons").get("filetype", opts.filetype)
        end,
      },
    }
  end,
  config = function(_, opts)
    require("bufferline").setup(opts)
    -- Redraw after buffer add/delete so the bar never shows stale entries.
    vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
}
