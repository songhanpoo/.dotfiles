return {
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      -- 1. Initialize nvim-surround with standard options
      require("nvim-surround").setup({})

      -- 2. Manually bind the visual mode override for v4
      -- This binds gS in visual mode to trigger the plug-in's visual surround function
      vim.keymap.set("x", "gS", "<Plug>(nvim-surround-visual)", { desc = "Visual Surround" })
    end,
  },
  {
    "echasnovski/mini.surround",
    enabled = false,
  },
}
