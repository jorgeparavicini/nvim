return {
  'nvim-telescope/telescope.nvim',
  tag = 'v0.2.2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  keys = {
    { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Lists files in your current working directory, respects .gitignore' },
    { '<leader>fg', function() require('telescope.builtin').live_grep() end, desc = 'Search for a string in your current working directory and get results live as you type, respects .gitignore.' },
    { '<leader>fb', function() require('telescope.builtin').buffers() end, desc = 'Lists open buffers in current neovim instance' },
    { '<leader>fh', function() require('telescope.builtin').help_tags() end, desc = 'Lists available help tags and opens a new window with the relevant help info on <cr>' },
  },
  config = function()
    require('telescope').setup({
      extensions = { fzf = {} },
    })
    require('telescope').load_extension('fzf')
  end,
}
