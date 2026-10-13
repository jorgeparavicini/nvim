return {
  "saghen/blink.cmp",
  version = "1.*",
  event = "InsertEnter",
  dependencies = { "rafamadriz/friendly-snippets", "nvim-mini/mini.icons" },
  opts = {
    -- <CR> accepts, <Tab>/<S-Tab> move through the list or snippet fields,
    -- <C-space> opens the menu / docs, <C-e> closes it.
    keymap = {
      preset = "enter",
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    appearance = { nerd_font_variant = "mono" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "lazydev" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
    completion = {
      list = { selection = { preselect = true, auto_insert = false } },
      menu = {
        border = "rounded",
        draw = {
          treesitter = { "lsp" },
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
          components = {
            kind_icon = {
              text = function(ctx)
                local icon = require("mini.icons").get("lsp", ctx.kind)
                return icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                local _, hl = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
            kind = {
              highlight = function(ctx)
                local _, hl = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
          },
        },
      },
      documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = "rounded" } },
      ghost_text = { enabled = true },
    },
    signature = { enabled = true, window = { border = "rounded" } },
  },
}
