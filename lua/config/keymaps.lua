-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Resize window using <alt/option> arrow keys
vim.keymap.set("n", "<M-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<M-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<M-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<M-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard register" })
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+Y', { desc = "Yank to clipboard register" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard register" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste back clipboard register" })

vim.keymap.set({ "n" }, "gl", "`[v`]", { desc = "Select last yanked or changed text" })
vim.keymap.set({ "n" }, "gL", "`[V`]", { desc = "Select last yanked or changed text block wise" })

vim.keymap.set({ "n" }, "<leader>by", "<cmd>let @+=expand('%:.')<cr>", { desc = "Yank file path relative to root" })
vim.keymap.set({ "n" }, "<leader>bY", "<cmd>let @+=expand('%:p')<cr>", { desc = "Yank absolute file path" })
vim.keymap.set({ "n" }, "<leader>bn", "<cmd>let @+=expand('%:t')<cr>", { desc = "Yank filename of current buffer" })
