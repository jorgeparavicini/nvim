return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = "auto",
      globalstatus = true,
      component_separators = "|",
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = {
        "filename",
      },
      lualine_x = {
        "encoding",
        "fileformat",
        "filetype",
        "lsp_status",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    extensions = { "lazy" },
  },
}
