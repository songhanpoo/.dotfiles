-- lazy.nvim
return {
  "Showwaiyan/antigravity.nvim",
  config = function()
    require("antigravity").setup({
      -- Optional configuration overrides
      cmd = "agy",
      disable_links = false, -- Set to true to disable clickable markdown/file:// links and use plain text names
      ask = {
        split = "right", -- "right", "left", "above", "below"
        width = 0.4, -- fractional width (40%) or absolute column count
      },
      mappings = {
        -- Custom terminal buffer mappings for scrolling the chat history.
        -- Set to nil or empty string to disable.
        scroll_up = "<C-u>", -- e.g. <leader>up
        scroll_down = "<C-d>", -- e.g. <leader>dn
      },
    })
  end,
  keys = {
    { "<leader>aa", "<cmd>AntigravityAsk<cr>", desc = "Ask Antigravity (Normal Mode)" },
    { "<leader>aa", ":AntigravityAsk ", mode = "v", desc = "Ask Antigravity (Visual Selection)" },
    { "<leader>as", "<cmd>AntigravitySelect<cr>", desc = "Select Preset Prompt (Normal Mode)" },
    { "<leader>as", ":AntigravitySelect<cr>", mode = "v", desc = "Select Preset Prompt (Visual Selection)" },
    { "<leader>at", "<cmd>AntigravityToggle<cr>", desc = "Toggle Antigravity Terminal" },
  },
}
