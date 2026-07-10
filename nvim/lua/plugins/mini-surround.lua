return {
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          -- Sets the visual mode surround key to gS instead of S
          visual = "gS",
        },
      })
    end,
  },
  {
    "echasnovski/mini.surround",
    enabled = false,
  },
}
