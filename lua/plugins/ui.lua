vim.g.material_style = "darker"
return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>fN",
        function()
          require("telescope").extensions.notify.notify()
        end,
        desc = "Notifications",
      },
    },
    opts = {
      render = "compact",
    },
  },
  {
    "akinsho/bufferline.nvim",
    keys = {
      {
        "<leader>b[",
        "<Cmd>BufferLineCyclePrev<CR>",
        desc = "Previous buffer",
      },
      {
        "<leader>b]",
        "<Cmd>BufferLineCycleNext<CR>",
        desc = "Next buffer",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        globalstatus = false,
      },
    },
  },
}
