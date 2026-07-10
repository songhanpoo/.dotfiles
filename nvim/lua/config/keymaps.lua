-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
-- local ok, wk = pcall(require, "which-key")
-- if ok then
--   wk.add({
--     { "<leader>i", group = "iOS / XcodeBuild" },
--   })
-- end
-- Press Ctrl+b in Visual Mode to instantly wrap selection in **
vim.keymap.set("v", "<C-b>", "gS**", { remap = true, desc = "Markdown Bold Selection" })
vim.keymap.set("v", "<C-k>", "gS]", { remap = true, desc = "Markdown Bold Selection" })
