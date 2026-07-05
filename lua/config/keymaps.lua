-- Your custom keybindings (leader = space).

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlights on search when pressing <Esc> in normal mode' })
vim.keymap.set('n', '<leader>w', '<cmd>write<CR>', { desc = 'Save the current file' })

vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Focus split window to the left' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Focus split window to the bottom' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Focus split window to the top' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Focus split window to the right' })
