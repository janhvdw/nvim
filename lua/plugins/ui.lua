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
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        globalstatus = false,
      },
    },
  },
}
