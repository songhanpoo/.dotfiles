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
    { "<ctrl-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Window Left" },
    { "<ctrl-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Window Down" },
    { "<ctrl-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Window Up" },
    { "<ctrl-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Window Right" },
  },
}
