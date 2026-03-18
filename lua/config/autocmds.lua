-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds hereby

local augroup = require("helpers").augroup

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("keymap_for_http"),
  pattern = { "http" },
  callback = function()
    vim.keymap.set(
      { "n" },
      "<leader><cr>",
      "<cmd>lua require('kulala').run()<cr>",
      { desc = "Send the http request", buffer = true }
    )
  end,
})
