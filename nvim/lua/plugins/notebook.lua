-- 📓 ipynb.nvim — modal Jupyter notebook editor for .ipynb files
--
-- NOTE: `lazy = false` is required. The plugin claims `.ipynb` files through a
-- `BufReadCmd` autocmd, which must exist *before* the file is read. With this
-- config's `defaults.lazy = true` and no event/ft/cmd trigger, the plugin would
-- otherwise never load and `.ipynb` files would open as raw JSON.
--
-- `ft = "ipynb"` does not work either: Neovim's built-in filetype detection maps
-- `*.ipynb` to `json`, and the notebook filetype is only set by the plugin itself
-- once it has taken over the buffer read.
return {
  {
    "ajbucci/ipynb.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "neovim/nvim-lspconfig",
      "folke/snacks.nvim", -- inline image rendering
      -- language icons come from LazyVim's mini.icons devicons shim
    },
    opts = {
      kernel = {
        auto_connect = false, -- start kernels explicitly with <leader>ks
        show_status = true,
        -- Leave nil: the plugin walks up from the notebook looking for
        -- .venv / venv / .virtualenv / env before falling back to system python3.
        -- Override per-session with :NotebookKernelStart /path/to/bin/python
        python_path = vim.fn.getcwd() .. "/.venv/bin/python",
      },
      -- pyright is configured with project root_dir (see lsp.lua), so mirror the
      -- code cells inside the project instead of a temp dir — otherwise imports
      -- resolve against /tmp and every `import numpy` is flagged as unresolved.
      shadow = {
        location = "workspace",
        dir = ".ipynb.nvim",
      },
      images = {
        enabled = true,
      },
      inspector = {
        auto_hover = {
          enabled = false, -- toggle per-session with <leader>kH
          delay = 500,
        },
      },
      -- `vim.lsp.buf.format()` is wrapped so each cell formats as its own
      -- document; ruff_format via conform still applies to plain .py files.
      format = {
        enabled = true,
        trailing_blank_lines = 0,
      },
      keymaps = {
        -- <C-CR> / <S-CR> / <M-CR> are not distinguishable under
        -- TERM=tmux-256color, so the <leader>k* menu keys are the reliable path.
        -- They stay mapped in case this runs in Kitty/Ghostty directly.
        execute_all_below = "<leader>kB",
      },
    },
  },

  -- 🗝️ which-key group label for the notebook keymaps
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>k", group = "notebook (ipynb)", icon = "📓" },
      },
    },
  },
}
