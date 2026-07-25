return {
  "folke/trouble.nvim",
  ---@module "trouble"
  ---@type trouble.Config
  opts = {
    win = {
      position = "right",
      size = {
        height = 100,
      },
    },
  },
  cmd = "Trouble",
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
  },
}
