-- Colorscheme. Loads eagerly and early so colors apply on startup.

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  opts = {
    flavour = "mocha",
    background = { light = "latte", dark = "mocha" },
    -- Let Ghostty's translucent, blurred background show through everywhere
    -- (explorer, pickers, popups); only the completion menu stays solid.
    transparent_background = true,
    float = { transparent = true, solid = false },
    custom_highlights = function()
      local none = { bg = "NONE" }
      return {
        NormalSB = none,
        SignColumnSB = none,
        SnacksNormalNC = none,
        SnacksPicker = none,
        SnacksPickerBorder = none,
        SnacksPickerInput = none,
        SnacksPickerInputBorder = none,
        WhichKey = none,
        WhichKeyBorder = none,
        TabLine = none,
        TabLineFill = none,
      }
    end,
    term_colors = true,
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      keywords = {},
      functions = {},
    },
    integrations = {
      blink_cmp = { style = "bordered" },
      dap = true,
      dap_ui = true,
      diffview = true,
      octo = true,
      flash = true,
      gitsigns = true,
      lsp_trouble = true,
      mason = true,
      mini = { enabled = true, indentscope_color = "" },
      neotest = true,
      noice = true,
      notify = true,
      render_markdown = true,
      snacks = { enabled = true, indent_scope_color = "" },
      treesitter = true,
      treesitter_context = true,
      which_key = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
        inlay_hints = { background = true },
      },
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
