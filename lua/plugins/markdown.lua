-- Markdown rendered in place: heading bars, bullets, checkboxes, tables,
-- shaded code blocks. The line under the cursor shows raw markdown so you
-- can edit it. <leader>um toggles rendering; images render via Snacks.image
-- (needs a kitty-graphics terminal such as Ghostty, plus ImageMagick for
-- anything that isn't a PNG).

return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
  ft = { "markdown" },
  ---@module "render-markdown"
  ---@type render.md.UserConfig
  opts = {
    completions = { lsp = { enabled = true } },
    code = { width = "block", right_pad = 1, left_pad = 1 },
    heading = { position = "inline" },
    checkbox = { enabled = true },
    latex = { enabled = false }, -- no latex parser/tooling installed
  },
  keys = {
    {
      "<leader>um",
      function()
        require("render-markdown").toggle()
      end,
      desc = "Toggle Markdown rendering",
    },
  },
}
