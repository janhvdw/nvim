return {
  {
    "mfussenegger/nvim-lint",
    -- Add ignore for line length rule
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint" },
      },
      linters = {
        ["markdownlint"] = {
          args = { "--disable", "MD013", "MD024", "--" },
        },
        ["markdownlint-cli2"] = {
          args = { "--disable", "MD013", "MD024", "--" },
        },
      },
    },
  },
}
