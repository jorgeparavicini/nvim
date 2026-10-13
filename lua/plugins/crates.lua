-- Cargo.toml: version info, completion, update/upgrade, feature toggles.
-- Runs as an in-process LSP so blink completes crate names/versions and
-- K shows crate info. Keys live under <leader>r in Cargo.toml buffers.

return {
  "saecki/crates.nvim",
  event = { "BufRead Cargo.toml" },
  opts = {
    completion = { crates = { enabled = true } },
    lsp = { enabled = true, actions = true, completion = true, hover = true },
  },
  config = function(_, opts)
    require("crates").setup(opts)
    vim.api.nvim_create_autocmd("BufRead", {
      group = vim.api.nvim_create_augroup("jorge_crates_keys", { clear = true }),
      pattern = "Cargo.toml",
      callback = function(ev)
        local crates = require("crates")
        local map = function(keys, fn, desc, mode)
          vim.keymap.set(mode or "n", keys, fn, { buffer = ev.buf, desc = desc })
        end
        map("<leader>rv", crates.show_versions_popup, "Versions")
        map("<leader>rf", crates.show_features_popup, "Features")
        map("<leader>rd", crates.show_dependencies_popup, "Dependencies")
        map("<leader>ru", crates.update_crate, "Update crate (semver compatible)")
        map("<leader>ru", crates.update_crates, "Update selected crates", "x")
        map("<leader>ra", crates.update_all_crates, "Update all crates")
        map("<leader>rU", crates.upgrade_crate, "Upgrade crate (latest)")
        map("<leader>rU", crates.upgrade_crates, "Upgrade selected crates", "x")
        map("<leader>rA", crates.upgrade_all_crates, "Upgrade all crates")
        map("<leader>rx", crates.expand_plain_crate_to_inline_table, "Expand to inline table")
        map("<leader>rX", crates.extract_crate_into_table, "Extract into table")
        map("<leader>rH", crates.open_homepage, "Open homepage")
        map("<leader>rR", crates.open_repository, "Open repository")
        map("<leader>rO", crates.open_documentation, "Open docs.rs")
        map("<leader>rC", crates.open_crates_io, "Open crates.io")
        map("<leader>rt", crates.toggle, "Toggle crate info virtual text")
        map("<leader>rr", crates.reload, "Reload crate info")
      end,
    })
  end,
}
