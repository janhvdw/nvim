-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Resize window using <alt/option> arrow keys
vim.keymap.set("n", "<M-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<M-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<M-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<M-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

vim.keymap.set({ "n", "v" }, "Y", '"*y', { desc = "Yank to clipboard register" })
