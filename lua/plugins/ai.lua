return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    enabled = false,
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    keys = {
      {
        "<leader>cpq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        mode = { "n", "v" },
        desc = "Quick chat",
      },
      {
        "<leader>cpc",
        "<cmd>CopilotChatToggle<cr>",
        mode = { "n", "v" },
        desc = "Toggle chat",
      },
      -- TODO add actual code mappings like Explain and Review
    },
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    config = function(_, opts)
      require("copilot").setup(opts)
      vim.cmd("Copilot disable")
    end,
  },
}
