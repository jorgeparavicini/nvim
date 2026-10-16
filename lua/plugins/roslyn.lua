-- C#: Microsoft's Roslyn language server (the one VS Code uses) via
-- roslyn.nvim. Replaces csharp-ls, which could not cope with a 300-project
-- solution. The server binary is installed by Mason from the Crashdummyy
-- registry (see lsp.lua) as the "roslyn" package.

return {
  "seblyng/roslyn.nvim",
  ft = { "cs" },
  ---@module "roslyn.config"
  ---@type RoslynNvimConfig
  opts = {
    -- Remember the chosen solution for the session so every buffer in the
    -- repo attaches to the same server instead of re-guessing.
    lock_target = true,
    -- When several solutions are found, prefer one at the repo root.
    choose_target = function(targets)
      local root = vim.fs.root(0, { ".git" }) or vim.uv.cwd()
      for _, t in ipairs(targets) do
        if vim.fs.dirname(t) == root then
          return t
        end
      end
      return nil
    end,
  },
  init = function()
    vim.lsp.config("roslyn", {
      settings = {
        ["csharp|background_analysis"] = {
          -- Analyse only open files; full-solution analysis on 11k files is
          -- what makes the editor crawl.
          dotnet_analyzer_diagnostics_scope = "openFiles",
          dotnet_compiler_diagnostics_scope = "openFiles",
        },
        ["csharp|inlay_hints"] = {
          csharp_enable_inlay_hints_for_implicit_object_creation = true,
          csharp_enable_inlay_hints_for_implicit_variable_types = true,
          csharp_enable_inlay_hints_for_lambda_parameter_types = true,
          csharp_enable_inlay_hints_for_types = true,
          dotnet_enable_inlay_hints_for_indexer_parameters = true,
          dotnet_enable_inlay_hints_for_literal_parameters = true,
          dotnet_enable_inlay_hints_for_object_creation_parameters = true,
          dotnet_enable_inlay_hints_for_other_parameters = true,
          dotnet_enable_inlay_hints_for_parameters = true,
          dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
          dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
          dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
        },
        ["csharp|code_lens"] = {
          dotnet_enable_references_code_lens = true,
        },
        ["csharp|completion"] = {
          dotnet_show_completion_items_from_unimported_namespaces = true,
          dotnet_show_name_completion_suggestions = true,
        },
      },
    })
  end,
}
