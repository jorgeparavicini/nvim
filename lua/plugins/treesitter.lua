return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({
      "lua",
      "vim",
      "vimdoc",
      "rust",
      "markdown",
      "markdown_inline",
      "python",
      "yaml",
      "c_sharp",
      "regex",
      "json",
      "toml",
      "bash",
    })
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
      end,
    })
  end,
}
