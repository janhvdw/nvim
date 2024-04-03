return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      -- Add ignore for line length rule
      return vim.tbl_deep_extend("force", opts, {
        linters = {
          markdownlint = {
            args = { "--disable", "MD013", "--" },
          },
        },
      })
    end,
  },
}
