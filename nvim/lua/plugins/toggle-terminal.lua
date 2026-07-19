return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 3,
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      function _G.set_terminal_keymaps()
        local map_opts = { buffer = 0 }
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], map_opts)
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], map_opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], map_opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], map_opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], map_opts)
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], map_opts)
      end

      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
    keys = {
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal Horizontal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Terminal Vertical" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal Float" },
      { "<leader>tt", "<cmd>ToggleTerm direction=tab<cr>", desc = "Terminal Tab" },
    },
  },
}
