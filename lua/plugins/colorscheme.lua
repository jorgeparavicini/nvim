-- Colorscheme. Loads eagerly and early so colors apply on startup.

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  opts = {
    flavour = "mocha",
    background = { light = "latte", dark = "mocha" },
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
      flash = true,
      gitsigns = true,
      lsp_trouble = true,
      mason = true,
      mini = { enabled = true, indentscope_color = "" },
      neotest = true,
      noice = true,
      notify = true,
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
