local cwd_in_vault = require("helpers").is_cwd_in_vault

vim.g.material_style = "darker"

return {
  { "shaunsingh/nord.nvim" },
  { "sainnhe/gruvbox-material" },
  { "vague-theme/vague.nvim" },
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
