local helpers = require("helpers")
return {
  -- Disable render markdown in favour of Obsidian.nvim ui
  { "MeanderingProgrammer/render-markdown.nvim", enabled = false },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = { "nvim-mini/mini.icons", "saghen/blink.cmp" },
    opts = function()
      local presets = require("markview.presets")
      return {
        preview = {
          hybrid_modes = { "n" },
          icon_provider = "mini",
        },
        --@type markview.config.markdown_inline
        markdown_inline = {
          checkboxes = {
            checked = { text = "󰗠", hl = "MarkviewCheckboxChecked", scope_hl = "MarkviewCheckboxChecked" },
            unchecked = { text = "󰄰", hl = "MarkviewCheckboxUnchecked", scope_hl = "MarkviewCheckboxUnchecked" },

            ["/"] = { text = "󱎖", hl = "MarkviewCheckboxPending" },
            [">"] = { text = "", hl = "MarkviewCheckboxCancelled" },
            ["<"] = { text = "󰃖", hl = "MarkviewCheckboxProgress" },
            ["-"] = { text = "󰍶", hl = "MarkviewCheckboxCancelled", scope_hl = "MarkviewCheckboxStriked" },
            ["~"] = { text = "󰍶", hl = "MarkviewCheckboxCancelled", scope_hl = "MarkviewCheckboxStriked" },

            ["?"] = { text = "󰋗", hl = "MarkviewCheckboxPending" },
            ["!"] = { text = "󰀦", hl = "MarkviewCheckboxUnchecked" },
            ["*"] = { text = "󰓎", hl = "MarkviewCheckboxPending" },
          },
        },
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
    version = "*",
    cond = function()
      return helpers.is_cwd_in_vault()
    end,
    dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim", "Saghen/blink.cmp", "OXY2DEV/markview.nvim" },
    opts = {
      legacy_commands = false,
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
      ui = {
        enbled = true,
      },
      attachments = {
        img_text_func = function(path)
          local format_string = {
            markdown = "![](%s)",
            wiki = "![[%s]]",
          }
          local relative_path = vim.fn.fnamemodify(tostring(path), ":.")

          local style = Obsidian.opts.preferred_link_style
          return string.format(format_string[style], relative_path)
        end,
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
      require("config.keymaps").set_obsidian_keymap()
      require("obsidian").setup(opts)
    end,
  },
}
