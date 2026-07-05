-- Treesitter: syntax highlighting via real parsers.
-- Pinned to `master` (the frozen-but-working branch for Neovim 0.11).

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  build = ':TSUpdate',
  -- Use `opts` (lazy's preferred style), but override the module lazy calls.
  -- By default lazy would call require('nvim-treesitter').setup(opts) -- the
  -- wrong function. The config setup lives at 'nvim-treesitter.configs'.
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = { 'lua', 'vim' },
    highlight = { enable = true },
  },
}
