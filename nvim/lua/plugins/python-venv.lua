return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-lua/plenary.nvim",
    -- LazyVim provides snacks by default, which works perfectly as a backend picker
    "folke/snacks.nvim",
  },
  lazy = true,
  ft = "python",
  keys = {
    { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
  },
  config = function()
    require("venv-selector").setup({
      -- 🌟 FIX: Choose your active UI picker (snacks, telescope, or fzf-lua)
      picker = {
        name = "snacks",
      },
      -- 🌟 FIX: Custom searches must live inside the 'settings' table in the modern API
      settings = {
        options = {
          notify_user_on_venv_activation = true,
        },
        search = {
          -- Tell it exactly what directories to scour for your environment matching
          my_workspace_envs = {
            type = "venv",
            name = { ".venv", "venv", "env" },
          },
        },
      },
    })
  end,
}
