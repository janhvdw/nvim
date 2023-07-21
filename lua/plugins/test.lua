return {
  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/neotest-jest" },
    opts = {
      adapters = {
        ["neotest-jest"] = {
          jestCommand = "npx jest --",
          jestConfigFile = "jest.config.js",
        },
      },
    },
  },
}
