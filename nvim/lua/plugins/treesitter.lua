return {
  -- 🌳 Treesitter (clean version, no duplication)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.folds = { enable = true } -- LazyVim key is `folds` on the main branch
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "html",
        "http",
        "graphql",
        "javascript",
        "json5",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "ninja",
        "rst",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "svelte",
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
  },

  -- 🍿 Snacks.nvim (Handles high-res terminal image parsing & snacks tree previews)
  {
    "folke/snacks.nvim",
    opts = {
      image = {
        enabled = true,
        doc = {
          inline = true, -- Renders inline when you open a .png file directly
          float = true, -- Allows floating hover previews
        },
      },
      explorer = {
        enabled = true, -- Ensures the built-in tree explorer backend handles image generation smoothly
      },
    },
  },
}
