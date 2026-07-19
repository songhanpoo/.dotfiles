return {
  "Showwaiyan/antigravity.nvim",
  config = function()
    require("antigravity").setup({
      cmd = "agy",
      disable_links = false,
      ask = {
        split = "right",
        width = 0.4,
      },
      mappings = {
        scroll_up = "<C-u>",
        scroll_down = "<C-d>",
      },
    })
  end,
  keys = {
    { "<leader>ai", "<cmd>AntigravityAsk<cr>", desc = "AI Ask" },
    { "<leader>ap", "<cmd>AntigravitySelect<cr>", desc = "AI Prompt" },
    { "<leader>at", "<cmd>AntigravityToggle<cr>", desc = "AI Toggle" },
    { "<leader>ai", ":AntigravityAsk ", mode = "v", desc = "AI Ask Selection" },
    { "<leader>ap", ":AntigravitySelect<cr>", mode = "v", desc = "AI Prompt Selection" },
  },
}
