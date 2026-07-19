return {
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      keymap = {
        preset = "enter",
        ["<CR>"] = { "select_and_accept", "fallback" },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      })
    end,
  },
}
