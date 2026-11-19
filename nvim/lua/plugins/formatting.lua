-- LazyVim already wires conform.nvim (autoformat on save, <leader>cf); only add formatters here.
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "ruff_format", "ruff_organize_imports" },
      rust = { "rustfmt" },
    },
  },
}
