return {
  -- 1. Note Plugin Configuration
  {
    "gsuuon/note.nvim",
    cmd = "Note",
    ft = "note",
    init = function()
      -- Auto-create the ~/notes root folder
      local notes_dir = vim.fn.expand("~/notes")
      if vim.fn.isdirectory(notes_dir) == 0 then
        vim.fn.mkdir(notes_dir, "p")
      end
      -- note.nvim's ftplugin calls the removed `parsers.has_parser()` API;
      -- ftplugin/note.lua in this config shims it before that runs.
    end,
    keys = {
      -- 🌟 Shifted from <leader>n to <leader>o to protect notification history
      { "<leader>od", "<cmd>Note<cr>", desc = "Open Daily Note" },
      { "<leader>oi", "<cmd>NoteIndex<cr>", desc = "Open Workspace Index" },
      {
        "<leader>os",
        function()
          require("telescope.builtin").live_grep({
            cwd = require("note.api").current_note_root(),
          })
        end,
        desc = "Search Notes (Grep)",
      },
      { "<leader>oc", "<cmd>x<cr>", desc = "Save and Close Note" },
    },
    opts = {
      spaces = { "~" },
    },
  },

  -- 2. Prevent Tree-sitter installation attempts
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if not opts.ignore_install then
        opts.ignore_install = {}
      end
      table.insert(opts.ignore_install, "note")
    end,
  },

  -- 3. Bind descriptive names into LazyVim's Which-Key menu
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        -- 🌟 Registers the <leader>o group instead of overriding <leader>n
        { "<leader>o", group = "Notes/Organize" },
      }, -- This configures the floating window parameters for which-key v3
    },
  },
}
