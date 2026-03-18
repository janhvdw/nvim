-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Resize window using <alt/option> arrow keys
vim.keymap.set("n", "<M-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<M-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<M-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<M-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- System clipboard integration
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard register" })
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+Y', { desc = "Yank to clipboard register" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard register" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste back clipboard register" })

vim.keymap.set({ "n" }, "gl", "`[v`]", { desc = "Select last yanked or changed text" })
vim.keymap.set({ "n" }, "gL", "`[V`]", { desc = "Select last yanked or changed text block wise" })

-- Buffer path
vim.keymap.set({ "n" }, "<leader>by", "<cmd>let @+=expand('%:.')<cr>", { desc = "Yank file path relative to root" })
vim.keymap.set({ "n" }, "<leader>bY", "<cmd>let @+=expand('%:p')<cr>", { desc = "Yank absolute file path" })
vim.keymap.set({ "n" }, "<leader>bn", "<cmd>let @+=expand('%:t')<cr>", { desc = "Yank filename of current buffer" })

-- Markdown specific keymaps
vim.api.nvim_create_autocmd("FileType", {
  group = require("helpers").augroup("keymap_for_markdown"),
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

-- Obsidian.nvim related key maps, only loaded if the plugin loads
local function set_obsidian_keymap()
  require("which-key").add({
    { "<leader>o", group = "obsidian" },
    { "<leader>od", group = "dailies" },
    { "<leader>of", group = "find" },
  })

  require("which-key").add({ "<leader>od", group = "dailies" })
  vim.keymap.set({ "n" }, "<leader>odt", "<cmd>Obsidian today<cr>", { desc = "Open daily not for today" })
  vim.keymap.set({ "n" }, "<leader>ody", "<cmd>Obsidian yesterday<cr>", { desc = "Open daily not for yesterday" })
  vim.keymap.set({ "n" }, "<leader>odm", "<cmd>Obsidian tomorrow<cr>", { desc = "Open daily not for tomorrow" })
  vim.keymap.set({ "n" }, "<leader>odd", "<cmd>Obsidian dailies -14 15<cr>", { desc = "Daily note picker" })

  vim.keymap.set({ "n" }, "<leader>on", "<cmd>Obsidian new<cr>", { desc = "New note" })
  vim.keymap.set({ "n" }, "<leader>oN", "<cmd>Obsidian new_from_template<cr>", { desc = "New note from template" })

  require("which-key").add({ "<leader>of", group = "find" })
  vim.keymap.set({ "n" }, "<leader>ofg", "<cmd>Obsidian search<cr>", { desc = "Find with grep" })
  vim.keymap.set({ "n" }, "<leader>off", "<cmd>Obsidian quick_switch<cr>", { desc = "File" })
  vim.keymap.set({ "n" }, "<leader>oft", "<cmd>Obsidian tags<cr>", { desc = "Tag" })

  vim.api.nvim_create_autocmd("User", {
    group = require("helpers").augroup("keymap_for_obsidian"),
    pattern = "ObsidianNoteEnter",
    callback = function(ev)
      -- Overrides the `gf` mapping to work on Markdown/wiki links within your vault.
      local function gf_passtrough()
        return require("obsidian").util.gf_passthrough()
      end
      vim.keymap.set({ "n" }, "gf", gf_passtrough, { remap = true, buffer = ev.buf, desc = "Follow link" })
      vim.keymap.set({ "n" }, "<leader>oc", "<cmd>Obsidian toc<cr>", { buffer = ev.buf, desc = "Pick from ToC" })
      vim.keymap.set({ "n" }, "<leader>ol", "<cmd>Obsidian links<cr>", { buffer = ev.buf, desc = "Pick link" })
      vim.keymap.set({ "v" }, "<leader>oL", "<cmd>Obsidian link<cr>", { buffer = ev.buf, desc = "Link selected text" })
      vim.keymap.set({ "n" }, "<leader>ox", "<cmd>Obsidian open<cr>", { buffer = ev.buf, desc = "Open in Obsidian" })

      require("which-key").add({
        { "<leader>oi", group = "insert", buffer = ev.buf },
        { "<leader>of", group = "find", buffer = ev.buf },
      })

      -- Open
      vim.keymap.set({ "n" }, "<leader>oo", "<cmd>Obsidian follow_link<cr>", { buffer = ev.buf, desc = "Open link" })
      vim.keymap.set(
        { "n" },
        "<leader>oOl",
        "<cmd>Obsidian follow_link vsplit<cr>",
        { buffer = ev.buf, desc = "vsplit" }
      )
      vim.keymap.set(
        { "n" },
        "<leader>oOj",
        "<cmd>Obsidian follow_link hsplit<cr>",
        { buffer = ev.buf, desc = "hsplit" }
      )

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
      -- Backlinks will only work while you are in a note, other find commands are set whenever you are in a vault.
      vim.keymap.set({ "n" }, "<leader>ofb", "<cmd>Obsidian backlinks<cr>", { buffer = ev.buf, desc = "Backlinks" })
    end,
  })
end

return {
  set_obsidian_keymap = set_obsidian_keymap,
}
