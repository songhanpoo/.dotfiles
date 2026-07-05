return {
  -- 2. Enable and configure nvim-surround instead
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omits breaking changes
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- You can leave this empty to use the standard default keymaps
      })
    end,
  },
}
