return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    tag = "v1.4.0",
    dependencies = {
      { "antosha417/nvim-lsp-file-operations", config = true },
    },
    opts = {
      servers = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
              },
              checkOnSave = {
                command = "clippy",
              },
            },
          },
        },
        svelte = {},
        pyright = {
          -- Helps pyright locate your poetry/virtualenv project roots smoothly
          root_dir = function(filename)
            local util = require("lspconfig.util")
            return util.root_pattern("pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git")(filename)
              or util.path.dirname(filename)
          end,
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
        ruff = {},
        terraformls = {},

        markdown_oxide = {
          keyword_pattern = [[\(\k\| \|\/\|#\)\+]],
        },

        sourcekit = {

          cmd = { "xcrun", "sourcekit-lsp" },
          filetypes = { "swift", "objective-c", "objective-cpp" },
          -- FIXED: Fallback to the current file's directory so it works on single files!
          root_dir = function(filename, _)
            local util = require("lspconfig.util")
            local project_root = util.root_pattern("buildServer.json", "Package.swift", ".git")(filename)

            if project_root then
              return project_root
            end
            -- Fallback option
            return util.path.dirname(filename)
          end,
        },

        -- Integrated tailwindcss server options
        tailwindcss = {
          -- exclude a filetype from the default_config
          filetypes_exclude = { "markdown" },
          -- add additional filetypes to the default_config
          filetypes_include = {},
          -- additional settings for the server
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

              opts.desc = "Go to definition"
              vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

              opts.desc = "Go to declaration"
              vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

              opts.desc = "Go to implementation"
              vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)

              opts.desc = "Go to type definition"
              vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)

              opts.desc = "Show references"
              vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            end,
          })
        end,

        -- Integrated tailwindcss specific dynamic setup handler
        tailwindcss = function(_, opts)
          opts.filetypes = opts.filetypes or {}

          -- FIXED: Safe fallback method to extract default filetypes from v1.4.0 lspconfig mapping
          local default_ftp = {}
          local status, lsp_tailwind = pcall(require, "lspconfig.configs.tailwindcss")
          if status and lsp_tailwind and lsp_tailwind.default_config then
            default_ftp = lsp_tailwind.default_config.filetypes or {}
          end
          vim.list_extend(opts.filetypes, default_ftp)

          -- Remove excluded filetypes
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
