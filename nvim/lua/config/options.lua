-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = " "
-- Folding: nvim-treesitter's `main` branch dropped the `nvim_treesitter#foldexpr()`
-- autoload function, and setting foldmethod/foldexpr globally also stops
-- LazyVim's per-filetype `set_default` from ever applying. Leave both unset so
-- LazyVim installs `v:lua.LazyVim.treesitter.foldexpr()` per buffer, and so
-- ipynb.nvim's own cell foldexpr keeps working in notebook buffers.
vim.opt.foldenable = true
vim.opt.foldlevel = 99 -- Keep all folds open by default
-- Examples for configuration profiles:
-- 1. VSCode Style: Block in Normal, Thin Vertical Line in Insert Mode
-- vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
--
-- -- 2. Make the line blink across all modes
-- vim.opt.guicursor = "a:blinkon100"
--
-- -- 3. Always a static non-blinking block everywhere
-- vim.opt.tabstop = 4
-- vim.opt.guicursor = "a:block"
