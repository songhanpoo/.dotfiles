return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<leader>wh", "<cmd>TmuxNavigateLeft<cr>", desc = "Window Left" },
    { "<leader>wj", "<cmd>TmuxNavigateDown<cr>", desc = "Window Down" },
    { "<leader>wk", "<cmd>TmuxNavigateUp<cr>", desc = "Window Up" },
    { "<leader>wl", "<cmd>TmuxNavigateRight<cr>", desc = "Window Right" },
  },
}
