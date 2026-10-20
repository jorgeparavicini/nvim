-- Linters that aren't language servers. Today: actionlint on GitHub
-- workflow files (expression typos, bad `needs:` refs, unknown action
-- inputs, shellcheck on run: blocks). yamlls + SchemaStore already validate
-- the workflow schema; this catches what a schema can't.

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile", "BufWritePost" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {}

    local group = vim.api.nvim_create_augroup("jorge_lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
      group = group,
      pattern = { "*/.github/workflows/*.yml", "*/.github/workflows/*.yaml" },
      callback = function()
        lint.try_lint("actionlint")
      end,
    })
  end,
}
