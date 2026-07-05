return
-- 🌳 Treesitter (clean version, no duplication)
{
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {
      "ansible-lint",
      "bash",
      "html",
      "javascript",
      "json5",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "tsx",
      "typescript",
      "vim",
      "yaml",
      "terraform",
      "hcl",
      "swift",
      "go",
      "gomod",
      "gowork",
      "gosum",
      "dockerfile",
    })
  end,
}
