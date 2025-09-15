return {
  -- Disable render markdown in favour of Obsidian.nvim ui
  { "MeanderingProgrammer/render-markdown.nvim", enabled = false },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local presets = require("markview.presets")
      return {
        preview = {
          hybrid_modes = { "n" },
        },
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
        markdown = {
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
          },
        },
      }
    end,
  },
  {
    "obsidian-nvim/obsidian.nvim",
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
      { "<leader>odd", "<cmd>ObsidianDailies -14 15<cr>", desc = "Daily note picker" },
    },
    dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim", "Saghen/blink.cmp", "OXY2DEV/markview.nvim" },
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
      completion = {
        nvim_cmp = false,
        blink = true,
      },
      picker = {
        name = "snacks.pick",
        note_mappings = {
          -- Create a new note from your query.
          new = "<C-x>",
          -- Insert a link to the selected note.
          insert_link = "<C-l>",
        },
        tag_mappings = {
          -- Add tag(s) to current note.
          tag_note = "<C-x>",
          -- Insert a tag at the current location.
          insert_tag = "<C-l>",
        },
      },
      ui = { enable = false },
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
      require("which-key").add({ "<leader>o", group = "obsidian" })
    end,
  },
}
