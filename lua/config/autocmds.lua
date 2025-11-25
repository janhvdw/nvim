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
    vim.opt_local.spell = false
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = augroup("keymap_for_obsidian"),
  pattern = "ObsidianNoteEnter",
  callback = function(ev)
    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
    vim.keymap.set({ "n" }, "gf", function()
      return require("obsidian").util.gf_passthrough()
    end, { noremap = false, expr = true, buffer = ev.buf, desc = "Follow link" })
    vim.keymap.set({ "n" }, "<leader>on", "<cmd>Obsidian new<cr>", { buffer = ev.buf, desc = "New note" })
    vim.keymap.set(
      { "n" },
      "<leader>oN",
      "<cmd>Obsidian new_from_template<cr>",
      { buffer = ev.buf, desc = "New note from template" }
    )
    vim.keymap.set({ "n" }, "<leader>oc", "<cmd>Obsidian toc<cr>", { buffer = ev.buf, desc = "Pick from ToC" })
    vim.keymap.set({ "n" }, "<leader>ol", "<cmd>Obsidian links<cr>", { buffer = ev.buf, desc = "Pick link" })
    vim.keymap.set({ "v" }, "<leader>oL", "<cmd>Obsidian link<cr>", { buffer = ev.buf, desc = "Link selected text" })
    vim.keymap.set({ "n" }, "<leader>ox", "<cmd>Obsidian open<cr>", { buffer = ev.buf, desc = "Open in Obsidian" })

    require("which-key").add({
      { "<leader>oO", group = "open", buffer = ev.buf },
      { "<leader>oi", group = "insert", buffer = ev.buf },
      { "<leader>of", group = "find", buffer = ev.buf },
    })

    -- Open
    vim.keymap.set({ "n" }, "<leader>oo", "<cmd>Obsidian follow_link<cr>", { buffer = ev.buf, desc = "Open link" })
    vim.keymap.set({ "n" }, "<leader>oOl", "<cmd>Obsidian follow_link vsplit<cr>", { buffer = ev.buf, desc = "vsplit" })
    vim.keymap.set({ "n" }, "<leader>oOj", "<cmd>Obsidian follow_link hsplit<cr>", { buffer = ev.buf, desc = "hsplit" })

    -- Insert
    vim.keymap.set({ "n" }, "<leader>oii", "<cmd>Obsidian paste_img<cr>", { buffer = ev.buf, desc = "Image" })
    vim.keymap.set({ "n" }, "<leader>oit", "<cmd>Obsidian template<cr>", { buffer = ev.buf, desc = "Template" })
    vim.keymap.set({ "n" }, "<leader>oij", "a[](<c-r>+)<esc>yT/F[pE", { buffer = ev.buf, desc = "JIRA link" })
    vim.keymap.set(
      { "n" },
      "<leader>oip",
      'a[](<c-r>+)<esc>"nyT/2F/yT/F[pa/PR-<c-r>n<esc>E',
      { desc = "Azure PR link", buffer = true }
    )

    -- Find
    vim.keymap.set({ "n" }, "<leader>ofg", "<cmd>Obsidian search<cr>", { buffer = ev.buf, desc = "Find with grep" })
    vim.keymap.set({ "n" }, "<leader>off", "<cmd>Obsidian quick_switch<cr>", { buffer = ev.buf, desc = "File" })
    vim.keymap.set({ "n" }, "<leader>ofb", "<cmd>Obsidian backlinks<cr>", { buffer = ev.buf, desc = "Backlinks" })
    vim.keymap.set({ "n" }, "<leader>oft", "<cmd>Obsidian tags<cr>", { buffer = ev.buf, desc = "Tag" })
  end,
})
