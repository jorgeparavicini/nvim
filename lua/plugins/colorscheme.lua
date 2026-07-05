-- Colorscheme. Loads eagerly and early so colors apply on startup.

return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  lazy = false,
  config = function()
    vim.cmd.colorscheme('catppuccin')
  end,
}
