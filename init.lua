-- Entry point. Keep this tiny: set the leader key, then load the modules.

-- Leader must be set BEFORE lazy.nvim loads so plugin keymaps pick it up.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- These are Lua module paths: 'config.options' => lua/config/options.lua
require("config.options")
require("config.keymaps")
require("config.lazy")
