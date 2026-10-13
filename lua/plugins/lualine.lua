return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      theme = "catppuccin-nvim",
      globalstatus = true,
      component_separators = { left = "\u{E0B1}", right = "\u{E0B3}" },
      section_separators = { left = "\u{E0B4}", right = "\u{E0B6}" },
      disabled_filetypes = { statusline = { "snacks_dashboard" } },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = {
        {
          "diagnostics",
          symbols = { error = "󰅚 ", warn = "󰀪 ", info = "󰋽 ", hint = "󰌶 " },
        },
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { "filename", path = 1, symbols = { modified = " \u{F111}", readonly = " \u{F023}", unnamed = "" } },
      },
      lualine_x = {
        {
          "diff",
          symbols = { added = "\u{F457} ", modified = "\u{F459} ", removed = "\u{F458} " },
        },
        { "lsp_status", icon = "\u{F085}", ignore_lsp = { "null-ls" } },
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    extensions = { "lazy", "mason", "quickfix", "trouble" },
  },
}
