return {
  -- Disable render markdown in favour of Obsidian.nvim ui
  { "MeanderingProgrammer/render-markdown.nvim", enabled = false },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = function()
      local presets = require("markview.presets")
      return {
        hybrid_modes = { "n" },
        checkboxes = vim.tbl_deep_extend("force", presets.checkboxes.nerd, {
          custom = {
            {
              match_string = "-",
              text = "",
              hl = "MarkviewCheckboxPending",
            },
            {
              match_string = ">",
              text = "",
              hl = "MarkviewCheckboxProgress",
            },
            {
              match_string = "~",
              text = "",
              hl = "MarkviewCheckboxCancelled",
            },
          },
        }),

        list_items = {
          ---+ ${class, List items}
          enable = true,
          indent_size = 2,
          shift_width = 2,

          marker_minus = {
            add_padding = false,
            text = "•",
            hl = "MarkviewListItemMinus",
          },
          marker_plus = {
            add_padding = false,
            text = "‣",
            hl = "MarkviewListItemPlus",
          },

          marker_star = {
            add_padding = false,
            text = "⚝",
            hl = "MarkviewListItemStar",
          },
          marker_dot = {
            add_padding = false,
          },
          marker_parenthesis = {
            add_padding = false,
          },
          ---_
        },
      }
    end,
  },
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
      { "<leader>odd", "<cmd>ObsidianDailies -30 31<cr>", desc = "Daily note picker" },
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
          path = vim.fn.expand("~") .. "/vaults/private/",
        },
      },
      daily_notes = {
        folder = "dailies",
        alias_format = "%A, %Y-%m-%d (W%V)",
        template = "daily",
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
          opts = { desc = "Link selected text" },
        },
        ["<leader>oL"] = {
          action = "<cmd>ObsidianLinks<cr>",
          opts = { desc = "Open picker with all links in buffer" },
        },
        ["<leader>os"] = {
          action = "<cmd>ObsidianSearch<cr>",
          opts = { desc = "Search for a note" },
        },
        ["<leader>of"] = {
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
          action = "<cmd>ObsidianPasteImg<cr>",
          opts = { desc = "Paste image" },
        },
      },
      ui = {
        enable = false,
        -- checkboxes = {
        --   -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
        --   [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        --   ["x"] = { char = "", hl_group = "ObsidianDone" },
        --   [">"] = { char = "", hl_group = "ObsidianRightArrow" },
        --   ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        --   ["!"] = { char = "", hl_group = "ObsidianImportant" },
        --   -- Replace the above with this if you don't have a patched font:
        --   -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
        --   -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },
        -- },
      },
      templates = {
        folder = "templates",
        substitutions = {
          week = function()
            return os.date("%V")
          end,
          year = function()
            return os.date("%Y")
          end,
        },
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
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z1-9-]", ""):lower()
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
      vim.keymap.set("v", "<leader>ol", "<cmd>'<,'>ObsidianLink<cr>", { desc = "Link selected text" })
      vim.keymap.set("v", "<leader>oe", "<cmd>'<,'>ObsidianExtractNote<cr>", { desc = "Extract Note" })
    end,
  },
}
