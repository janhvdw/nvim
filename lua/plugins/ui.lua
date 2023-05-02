return {
  { "ellisonleao/gruvbox.nvim" },
  { "catppuccin/nvim", name = "catppuccin" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
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
}
