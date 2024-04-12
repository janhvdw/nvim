return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/vaults/**.md",
    },
    cmd = "ObsidianWorkspace",
    keys = {
      { "<leader>odt", "<cmd>ObsidianToday<cr>", desc = "Open daily not for today" },
      { "<leader>ody", "<cmd>ObsidianYesterday<cr>", desc = "Open daily not for yesterday" },
      { "<leader>odm", "<cmd>ObsidianTomorrow<cr>", desc = "Open daily not for tomorrow" },
      { "<leader>odd", "<cmd>ObsidianDailies -20 5", desc = "Daily note picker" },
    },
    dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp", "nvim-telescope/telescope.nvim" },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = vim.fn.expand("~") .. "/vaults/personal/",
        },
        {
          name = "private",
          path = vim.fn.expand("~") .. "/vaults/private",
        },
      },
      daily_notes = {
        folder = "dailies",
        alias_format = "%A, %Y-%m-%d (CW%V)",
        -- template = "daily.md",
      },
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true, desc = "Follow link" },
        },
        -- Toggle check-boxes.
        ["<leader>oc"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true, desc = "Toggle checkbox" },
        },
        ["<leader>ox"] = {
          action = "<cmd>ObsidianOpen<cr>",
          opts = { buffer = true, desc = "Open in Obsidian" },
        },
        ["<leader>on"] = {
          action = "<cmd>ObsidianNew<cr>",
          opts = { desc = "Create a new note" },
        },
        ["<leader>oo"] = {
          action = "<cmd>ObsidianFollowLink<cr>",
          opts = { desc = "Follow Link" },
        },
        ["<leader>ol"] = {
          action = "<cmd>ObsidianLink<cr>",
          opts = { desc = "link selected text" },
        },
        ["<leader>oL"] = {
          action = "<cmd>ObsidianLinks<cr>",
          opts = { desc = "link selected text" },
        },
        ["<leader>of"] = {
          action = "<cmd>ObsidianSearch<cr>",
          opts = { desc = "Search for a note" },
        },
        ["<leader>os"] = {
          action = "<cmd>ObsidianQuickSwitch<cr>",
          opts = { desc = "Search for a note" },
        },
        ["<leader>ot"] = {
          action = "<cmd>ObsidianTags<cr>",
          opts = { desc = "Pick tag search by" },
        },
        ["<leader>ob"] = {
          action = "<cmd>ObsidianBacklinks<cr>",
          opts = { desc = "Search back links" },
        },
        ["<leader>oi"] = {
          action = "<cmd>ObsidianPastImage<cr>",
          opts = { desc = "Paste image" },
        },
      },
      completion = {
        prepend_note_id = false,
        prepend_note_path = true,
      },
      wiki_link_func = function(opts)
        if opts.label ~= opts.path then
          return string.format("[[%s|%s]]", opts.path, opts.label)
        else
          return string.format("[[%s]]", opts.path)
        end
      end,
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. "-" .. suffix
      end,
    },
    config = function(_, opts)
      vim.o.conceallevel = 2
      require("obsidian").setup(opts)
      vim.keymap.set("v", "<leader>ol", "<cmd>'<,'>ObsidianLink<cr>", { desc = "link selected text" })
    end,
  },
}
