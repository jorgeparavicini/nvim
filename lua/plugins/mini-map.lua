-- Minimap column on the right: file shape as dots, visible region
-- highlighted, diagnostics / git changes / search matches marked.
-- Off by default; <leader>uM toggles, <leader>uF focuses it (Esc back).

return {
  "nvim-mini/mini.map",
  version = false,
  keys = {
    {
      "<leader>uM",
      function()
        require("mini.map").toggle()
      end,
      desc = "Toggle minimap",
    },
    {
      "<leader>uF",
      function()
        require("mini.map").toggle_focus()
      end,
      desc = "Focus minimap",
    },
  },
  opts = function()
    local map = require("mini.map")
    return {
      integrations = {
        map.gen_integration.builtin_search(),
        map.gen_integration.diagnostic({
          error = "DiagnosticFloatingError",
          warn = "DiagnosticFloatingWarn",
          info = "DiagnosticFloatingInfo",
          hint = "DiagnosticFloatingHint",
        }),
        map.gen_integration.gitsigns(),
      },
      symbols = {
        encode = map.gen_encode_symbols.dot("4x2"),
        scroll_line = "█",
        scroll_view = "┃",
      },
      window = {
        width = 16,
        winblend = 20,
        show_integration_count = false,
        zindex = 10,
      },
    }
  end,
  config = function(_, opts)
    local map = require("mini.map")
    map.setup(opts)
    -- Don't draw the map over pickers, terminals, the explorer or dashboards.
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("jorge_minimap", { clear = true }),
      pattern = { "snacks_*", "trouble", "neo-tree", "octo*", "DiffviewFiles", "qf", "help", "lazy", "mason" },
      callback = function(ev)
        vim.b[ev.buf].minimap_disable = true
      end,
    })
  end,
}
