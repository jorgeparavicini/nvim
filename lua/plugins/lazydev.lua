-- Configures lua_ls for Neovim config development: resolves the vim.* API and
-- plugin types (like snacks.Config) so you get completion and no false warnings.
return {
  "folke/lazydev.nvim",
  ft = "lua", -- only load when editing Lua
  opts = {
    library = {
      -- Load snacks types when the word `Snacks` is found in the file.
      { path = "snacks.nvim", words = { "Snacks" } },
    },
  },
}
