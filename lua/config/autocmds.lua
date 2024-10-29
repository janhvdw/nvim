-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds hereby

local function augroup(name)
  return vim.api.nvim_create_augroup("local_config_" .. name, { clear = true })
end

-- Highlight on yank
-- vim.api.nvim_create_autocmd("TextYankPost", {
--   group = augroup("yank_to_clipboard"),
--   callback = function(ev)
--     nvim.api.get
--     print(string.format("event fired: %s", vim.inspect(ev.data)))
--   end,
-- })

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

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("keymap_for_markdown"),
  pattern = { "markdown" },
  callback = function()
    vim.keymap.set(
      "v",
      "<leader>cj",
      "<esc><cmd>'<,'>!pandoc --from markdown-auto_identifiers -t jira --columns=999 --wrap=none<cr>",
      { desc = "Format for jira", buffer = true }
    )
    vim.keymap.set(
      { "n" },
      "<leader>cp",
      "<cmd>MarkdownPreviewToggle<cr>",
      { desc = "Toggle MarkdownPreview", buffer = true }
    )
    require("which-key").add({
      { "<leader>um", group = "markdown", buffer = true },
    })
    vim.keymap.set(
      { "n" },
      "<leader>umh",
      "<cmd>Markview hybridToggle<cr>",
      { desc = "Toggle Markview hybrid mode", buffer = true }
    )
    vim.keymap.set(
      { "n" },
      "<leader>ums",
      "<cmd>Markview splitToggle<cr>",
      { desc = "Toggle Markview split view", buffer = true }
    )
  end,
})
