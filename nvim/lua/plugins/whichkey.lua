return {
  "folke/which-key.nvim",
  opts = {
    -- 1. Use a standard layout configuration for vertical sizing
    layout = {
      spacing = 2, -- columns margin spacing
    },

    -- 2. Clean up window properties without throwing an invalid key error
    win = {
      -- Caps the menu height so it won't crowd or fill the entire screen space
      height = { min = 4, max = 100 },

      -- Pad the interior window space so content doesn't crash against edges
      padding = { 1, 1 }, -- { top/bottom, left/right }

      -- Enable 'no_overlap' to prevent the window from rendering over your active cursor line
      no_overlap = true,

      border = "rounded",
    },
  },
}
