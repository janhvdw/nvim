return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = function()
      return {
        {
          "<leader>e",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").root.get() })
          end,
          desc = "Explorer NeoTree (root dir)",
        },
        {
          "<leader>E",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
          end,
          desc = "Explorer NeoTree (cwd)",
        },
      }
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    opts = function(_, parentOpts)
      return vim.tbl_extend("keep", parentOpts, {
        modes = {
          char = {
            enabled = false,
          },
        },
      })
    end,
    --    -- stylua: ignore
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, parentOpts)
      local fb_actions = require("telescope._extensions.file_browser.actions")

      local ts_select_dir_for_grep = function(prompt_bufnr)
        local action_state = require("telescope.actions.state")
        local fb = require("telescope").extensions.file_browser
        local live_grep = require("telescope.builtin").live_grep
        local current_line = action_state.get_current_line()

        fb.file_browser({
          files = false,
          depth = false,
          attach_mappings = function(prompt_bufnr)
            require("telescope.actions").select_default:replace(function()
              local entry_path = action_state.get_selected_entry().Path
              local dir = entry_path:is_dir() and entry_path or entry_path:parent()
              local relative = dir:make_relative(vim.fn.getcwd())
              local absolute = dir:absolute()

              live_grep({
                results_title = relative .. "/",
                cwd = absolute,
                default_text = current_line,
              })
            end)

            return true
          end,
        })
      end

      return vim.tbl_extend("keep", parentOpts, {
        pickers = {
          buffers = {
            ignore_current_buffer = true,
            mappings = {
              i = {
                ["<c-d>"] = require("telescope.actions").delete_buffer,
              },
              n = {
                ["d"] = require("telescope.actions").delete_buffer,
              },
            },
          },
          file_browser = {
            -- disables netrw and use telescope-file-browser in its place
            -- hijack_netrw = true,
            -- mappings = {
            ["i"] = {
              ["<C-f>"] = fb_actions.toggle_browser,
            },
            --   ["n"] = {
            --     -- your custom normal mode mappings
            --   },
            -- },
          },
          live_grep = {
            mappings = {
              i = {
                ["<C-f>"] = ts_select_dir_for_grep,
              },
              n = {
                ["<C-f>"] = ts_select_dir_for_grep,
              },
            },
          },
        },
      })
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.load_extension("file_browser")
      telescope.setup(opts)
      vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>", { desc = "Command Panel" })
      vim.keymap.set("n", "<leader>fB", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "" })
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
}
