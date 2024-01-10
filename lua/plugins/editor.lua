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
    "nvim-telescope/telescope.nvim",
    opts = function(_, parentOpts)
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
        },
      })
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
    end,
  },
}
