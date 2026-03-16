local cwd_in_vault = require("helpers").cwd_in_vault

vim.g.material_style = "darker"

return {
  { "shaunsingh/nord.nvim" },
  { "sainnhe/gruvbox-material" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = cwd_in_vault() and "gruvbox-material" or "nord",
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
  { "akinsho/bufferline.nvim", enabled = false },
}
