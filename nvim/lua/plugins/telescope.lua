-- 🔭 Telescope tweaks
return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>sf",
      function()
        require("telescope.builtin").find_files({
          cwd = require("lazy.core.config").options.root,
        })
      end,
      desc = "Search Plugin Files",
    },
  },
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      winblend = 0,
    },
  },
}
