-- Bootstraps lazy.nvim, then loads every spec from lua/plugins/.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- `{ import = 'plugins' }` tells lazy to load every file in lua/plugins/.
-- Each of those files returns a plugin spec table.
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "catppuccin" } },
  -- lazy defaults to border = "none", which overrides vim.o.winborder; with
  -- transparent floats that leaves the window edges invisible.
  ui = { border = "rounded", title = " lazy.nvim ", title_pos = "center" },
  checker = { enabled = true },
})
