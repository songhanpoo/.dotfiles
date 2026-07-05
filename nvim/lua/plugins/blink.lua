return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter", -- Changes confirmation key to <Enter>

        -- Keeps Tab/S-Tab active for cycling through the menu lists
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
    },
  },
}
