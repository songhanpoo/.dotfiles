return {
  -- rust-analyzer is driven by rustaceanvim (from the LazyVim rust extra), not lspconfig
  {
    "mrcjkb/rustaceanvim",
    opts = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true, loadOutDirsFromCheck = true, buildScripts = { enable = true } },
            check = { command = "clippy" }, -- clippy diagnostics on save
            procMacro = { enable = true },
            completion = {
              callable = { snippets = "fill_arguments" }, -- fn(arg1, arg2) snippet on accept
              postfix = { enable = true }, -- .if .match .dbg .some .ok ...
            },
            inlayHints = {
              closingBraceHints = { minLines = 20 },
              lifetimeElisionHints = { enable = "skip_trivial" },
            },
          },
        },
      },
    },
  },

  -- blink.cmp: make sure snippets + lsp are sources for rust
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      sources = {
        per_filetype = {
          rust = { "lsp", "snippets", "path", "buffer" },
          toml = { "lsp", "snippets", "path", "buffer" }, -- crates.nvim completes via LSP in Cargo.toml
        },
      },
    },
  },
}
