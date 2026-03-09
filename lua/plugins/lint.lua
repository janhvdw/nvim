return {
  {
    "mfussenegger/nvim-lint",
    -- Add ignore for line length rule
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--disable", "MD013", "MD024", "--" },
        },
      },
    },
  },
}
