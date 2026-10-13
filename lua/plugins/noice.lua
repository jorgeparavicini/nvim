-- Replaces the bottom command line and message area with floating popups,
-- and shows LSP progress / hover docs with borders.

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
    },
    routes = {
      -- Send "written"/"undo" style one-liners to the small mini view
      -- instead of a full notification.
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
            { find = "%d fewer lines" },
            { find = "%d more lines" },
          },
        },
        view = "mini",
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      lsp_doc_border = true,
    },
  },
  keys = {
    { "<leader>sn", "", desc = "+noice" },
    {
      "<leader>snl",
      function()
        require("noice").cmd("last")
      end,
      desc = "Last message",
    },
    {
      "<leader>snh",
      function()
        require("noice").cmd("history")
      end,
      desc = "Message history",
    },
    {
      "<leader>sna",
      function()
        require("noice").cmd("all")
      end,
      desc = "All messages",
    },
    {
      "<leader>snd",
      function()
        require("noice").cmd("dismiss")
      end,
      desc = "Dismiss all",
    },
    {
      "<c-f>",
      function()
        if not require("noice.lsp").scroll(4) then
          return "<c-f>"
        end
      end,
      silent = true,
      expr = true,
      desc = "Scroll forward",
      mode = { "i", "n", "s" },
    },
    {
      "<c-b>",
      function()
        if not require("noice.lsp").scroll(-4) then
          return "<c-b>"
        end
      end,
      silent = true,
      expr = true,
      desc = "Scroll backward",
      mode = { "i", "n", "s" },
    },
  },
}
