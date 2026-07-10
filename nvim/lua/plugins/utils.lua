-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {

  -- prevent LazyVim overriding colorscheme
  --
  -- 🚫 Disable trouble (keep config clean)
  {
    "folke/trouble.nvim",
    enabled = false,
  },

  -- 🧪 Typescript extras (keep LazyVim magic)
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- 📊 Lualine tweak (keep only one version!)
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, function()
        return "😄"
      end)
    end,
  },

  -- 🧰 Mason tools
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "tflint",
      },
    },
  },
  -- 🎁 Extras
  { import = "lazyvim.plugins.extras.ui.mini-starter" },
  { import = "lazyvim.plugins.extras.lang.json" },
}
