-- Core editor options (no plugins involved).

vim.g.autoformat = true -- toggled with <leader>uf (see conform.lua)

-- UI
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.laststatus = 3 -- one global statusline
vim.o.showmode = false -- lualine shows the mode
vim.o.winborder = "rounded" -- rounded border on all floating windows
vim.o.pumblend = 10
-- Terminal window title: "<project folder> > path/to/file [+]"
vim.o.title = true
vim.o.titlestring = "%{fnamemodify(getcwd(), ':t')} \u{203A} %f%( %M%)"
vim.o.titlelen = 0
vim.o.pumheight = 12
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.smoothscroll = true
vim.o.wrap = false
vim.o.linebreak = true
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.fillchars = {
  eob = " ", -- hide the ~ column after the end of a buffer
  fold = " ",
  foldopen = "\u{F0D7}",
  foldsep = " ",
  foldclose = "\u{F0DA}",
}

-- Folding (treesitter based; icons come from snacks statuscolumn)
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldtext = ""

-- Editing
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.shiftround = true
vim.o.expandtab = true
vim.o.undofile = true
vim.o.virtualedit = "block"
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.confirm = true
vim.o.spelllang = "en"

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "split"

-- Windows
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.splitkeep = "screen"
vim.o.winminwidth = 5

-- Timing
vim.o.updatetime = 250
vim.o.timeoutlen = 400

-- Per-project .nvim.lua (trusted via :trust)
vim.o.exrc = true
