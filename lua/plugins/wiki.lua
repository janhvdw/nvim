-- Support for windows (not working very well)
local helpers = require("../helpers")

-- local HOME = "~"
-- putting the notes in windows for the sake of obsidian
local HOME = "/Users/janvdw"
if helpers.is_windows then
  HOME = string.gsub(vim.env.HOME, "\\", "/")
end

return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/vaults/**.md",
    },
    keys = {
      { "<leader>odt", "<cmd>ObsidianToday<cr>", desc = "Open daily not for today" },
      { "<leader>ody", "<cmd>ObsidianYesterday<cr>", desc = "Open daily not for yesterday" },
      { "<leader>odm", "<cmd>ObsidianTomorrow<cr>", desc = "Open daily not for tomorrow" },
    },
    dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp", "nvim-telescope/telescope.nvim" },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/vaults/personal",
        },
        {
          name = "work",
          path = "~/vaults/work",
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
      },
      completion = {
        prepend_note_id = false,
        prepend_note_path = true,
      },
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
  -- {
  --   "renerocksai/calendar-vim",
  -- },
  -- {
  --   "renerocksai/telekasten.nvim",
  --   dependencies = { "nvim-telescope/telescope.nvim", "renerocksai/calendar-vim" },
  --   opts = {
  --     home = vim.fn.expand(HOME .. "/kasten/personal"),
  --     dailies = "diary",
  --     weeklies = "diary",
  --     templates = vim.fn.expand(HOME .. "/kasten/templates"),
  --     template_new_note = vim.fn.expand(HOME .. "/kasten/templates/new_note.md"),
  --     template_new_daily = vim.fn.expand(HOME .. "/kasten/templates/new_daily.md"),
  --     template_new_weekly = vim.fn.expand(HOME .. "/kasten/templates/new_weekly.md"),
  --     vaults = {
  --       windows = {
  --         home = vim.fn.expand("/mnt/c/Users/jwesthui/kasten/personal"),
  --       },
  --     },
  --   },
  --   config = function(_, opts)
  --     require("telekasten").setup(opts)
  --     vim.keymap.set("n", "<leader>kp", ":Telekasten panel<CR>", { desc = "Command Panel" })
  --     vim.keymap.set("n", "<leader>kv", ":Telekasten switch_vault<CR>", { desc = "" })
  --     vim.keymap.set("n", "<c-Space>", ":lua require('telekasten').toggle_todo()<CR>", { desc = "Switch vaults" })
  --     vim.keymap.set("v", "<c-Space>", ":lua require('telekasten').toggle_todo({ v = true })<CR>", { desc = "" })
  --
  --     -- from suggested
  --     vim.keymap.set("n", "<leader>kf", ":lua require('telekasten').find_notes()<CR>", { desc = "Find note" })
  --     vim.keymap.set("n", "<leader>kd", ":lua require('telekasten').find_daily_notes()<CR>", { desc = "Find daily" })
  --     vim.keymap.set("n", "<leader>kg", ":lua require('telekasten').search_notes()<CR>", { desc = "Search in notes" })
  --     vim.keymap.set("n", "<leader>kk", ":lua require('telekasten').follow_link()<CR>", { desc = "Follow note link" })
  --     vim.keymap.set("n", "<leader>kt", ":lua require('telekasten').goto_today()<CR>", { desc = "To today" })
  --     vim.keymap.set("n", "<leader>kw", ":lua require('telekasten').goto_thisweek()<CR>", { desc = "To this week" })
  --     vim.keymap.set(
  --       "n",
  --       "<leader>kW",
  --       ":lua require('telekasten').find_weekly_notes()<CR>",
  --       { desc = "Find weekly note" }
  --     )
  --     vim.keymap.set("n", "<leader>kn", ":lua require('telekasten').new_note()<CR>", { desc = "New note" })
  --     vim.keymap.set(
  --       "n",
  --       "<leader>kN",
  --       ":lua require('telekasten').new_templated_note()<CR>",
  --       { desc = "New templated note" }
  --     )
  --     vim.keymap.set("n", "<leader>ky", ":lua require('telekasten').yank_notelink()<CR>", { desc = "Yank note link" })
  --     vim.keymap.set("n", "<leader>kc", ":lua require('telekasten').show_calendar()<CR>", { desc = "Show calendar" })
  --     vim.keymap.set("n", "<leader>kC", ":CalendarT<CR>", { desc = "Show calendar tab" })
  --     vim.keymap.set("n", "<leader>kb", ":lua require('telekasten').show_backlinks()<CR>", { desc = "Show backlinks" })
  --     vim.keymap.set(
  --       "n",
  --       "<leader>kF",
  --       ":lua require('telekasten').find_friends()<CR>",
  --       { desc = "Find others with link" }
  --     )
  --     vim.keymap.set("n", "<leader>#", ":lua require('telekasten').show_tags()<CR>", { desc = "Show tags" })
  --
  --     vim.keymap.set("i", "[[", "<ESC>:lua require('telekasten').insert_link({ i=true })<CR>")
  --   end,
  -- },
}
