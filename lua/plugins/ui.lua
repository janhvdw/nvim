vim.g.material_style = "darker"
return {
  { "sainnhe/gruvbox-material" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = vim.g.neovide and "gruvbox-material" or "tokyonight-night",
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
    enabled = false,
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
