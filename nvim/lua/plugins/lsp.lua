return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- 👍 Keep this one if you like file operations support, drop the cmp one
      { "antosha417/nvim-lsp-file-operations", config = true },
    },
    opts = {
      servers = {
        pyright = {},
        terraformls = {},

        markdown_oxide = {
          keyword_pattern = [[\(\k\| \|\/\|#\)\+]],
        },

        sourcekit = {
          cmd = { "xcrun", "sourcekit-lsp" },
          filetypes = { "swift", "objective-c", "objective-cpp" },
          root_dir = function(filename)
            local util = require("lspconfig.util")
            return util.root_pattern("buildServer.json", "Package.swift", ".git")(filename)
          end,
        },

        -- Integrated tailwindcss server options
        tailwindcss = {
          -- exclude a filetype from the default_config
          filetypes_exclude = { "markdown" },
          -- add additional filetypes to the default_config
          filetypes_include = {},
          -- to fully override the default_config, change the below
          -- filetypes = {}

          -- additional settings for the server, e.g:
          -- tailwindCSS = { includeLanguages = { someLang = "html" } }
          -- can be addeded to the settings table and will be merged with
          -- this defaults for Phoenix projects
          settings = {
            tailwindCSS = {
              includeLanguages = {
                elixir = "html-eex",
                eelixir = "html-eex",
                heex = "html-eex",
              },
            },
          },
        },
      },

      setup = {
        -- Wildcard handler for general LSP keymaps
        ["*"] = function(_, _)
          vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
              local bufnr = args.buf
              local opts = { noremap = true, silent = true, buffer = bufnr }

              opts.desc = "Show line diagnostics"
              vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

              opts.desc = "Show documentation for what is under cursor"
              vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            end,
          })
        end,

        -- Integrated tailwindcss specific dynamic setup handler
        tailwindcss = function(_, opts)
          opts.filetypes = opts.filetypes or {}

          -- Add default filetypes
          vim.list_extend(opts.filetypes, vim.lsp.config.tailwindcss.filetypes)

          -- Remove excluded filetypes
          --- @param ft string
          opts.filetypes = vim.tbl_filter(function(ft)
            return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
          end, opts.filetypes)

          -- Add additional filetypes
          vim.list_extend(opts.filetypes, opts.filetypes_include or {})
        end,
      },
    },
  },
}
