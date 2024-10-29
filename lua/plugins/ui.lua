vim.g.material_style = "darker"

local function cwdInVault()
  local re = vim.regex("^" .. vim.fn.expand("~/vaults/"))
  return not not re:match_str(vim.fn.getcwd())
end

return {
  { "shaunsingh/nord.nvim" },
  { "sainnhe/gruvbox-material" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = cwdInVault() and "gruvbox-material" or "nord",
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
