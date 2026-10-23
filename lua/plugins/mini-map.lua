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

    -- mini.map only knows how to sit at the editor's right edge. Re-anchor
    -- its float to the window it is showing, so a terminal or split on the
    -- right is not covered. Done by swapping the module's internal window
    -- geometry function, found through its upvalues; if that lookup ever
    -- fails (plugin update), the default behaviour stays.
    local H
    for i = 1, 20 do
      local name, value = debug.getupvalue(map.refresh, i)
      if name == "H" then
        H = value
        break
      end
    end
    if H and H.normalize_window_options then
      local original = H.normalize_window_options
      local last_src = nil
      H.normalize_window_options = function(win_opts, full)
        local res = original(win_opts, full)
        if full == false or full == nil then
          local win = vim.api.nvim_get_current_win()
          local cfg = vim.api.nvim_win_get_config(win)
          if cfg.relative == "" then
            last_src = win
          end
          if last_src and vim.api.nvim_win_is_valid(last_src) then
            local height = vim.api.nvim_win_get_height(last_src)
            res.relative = "win"
            res.win = last_src
            res.row = 0
            res.col = vim.api.nvim_win_get_width(last_src)
            res.height = math.max(1, height)
          end
        end
        return res
      end
    end
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
