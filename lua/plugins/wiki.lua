-- Support for windows (not working very well)
local helpers = require("../helpers")

-- local HOME = "~"
-- putting the notes in windows for the sake of obsidian
local HOME = "/mnt/c/Users/jwesthui"
if helpers.is_windows then
  HOME = string.gsub(vim.env.HOME, "\\", "/")
end

return {
  {
    "renerocksai/calendar-vim",
  },
  {
    "renerocksai/telekasten.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "renerocksai/calendar-vim" },
    opts = {
      home = vim.fn.expand(HOME .. "/kasten/personal"),
      dailies = "diary",
      weeklies = "diary",
      templates = vim.fn.expand(HOME .. "/kasten/templates"),
      template_new_note = vim.fn.expand(HOME .. "/kasten/templates/new_note.md"),
      template_new_daily = vim.fn.expand(HOME .. "/kasten/templates/new_daily.md"),
      template_new_weekly = vim.fn.expand(HOME .. "/kasten/templates/new_weekly.md"),
      vaults = {
        windows = {
          home = vim.fn.expand("/mnt/c/Users/jwesthui/kasten/personal"),
        },
      },
    },
    config = function(_, opts)
      require("telekasten").setup(opts)
      vim.keymap.set("n", "<leader>kp", ":Telekasten panel<CR>", { desc = "Command Panel" })
      vim.keymap.set("n", "<leader>kv", ":Telekasten switch_vault<CR>", { desc = "" })
      vim.keymap.set("n", "<c-Space>", ":lua require('telekasten').toggle_todo()<CR>", { desc = "Switch vaults" })
      vim.keymap.set("v", "<c-Space>", ":lua require('telekasten').toggle_todo({ v = true })<CR>", { desc = "" })

      -- from suggested
      vim.keymap.set("n", "<leader>kf", ":lua require('telekasten').find_notes()<CR>", { desc = "Find note" })
      vim.keymap.set("n", "<leader>kd", ":lua require('telekasten').find_daily_notes()<CR>", { desc = "Find daily" })
      vim.keymap.set("n", "<leader>kg", ":lua require('telekasten').search_notes()<CR>", { desc = "Search in notes" })
      vim.keymap.set("n", "<leader>kk", ":lua require('telekasten').follow_link()<CR>", { desc = "Follow note link" })
      vim.keymap.set("n", "<leader>kt", ":lua require('telekasten').goto_today()<CR>", { desc = "To today" })
      vim.keymap.set("n", "<leader>kw", ":lua require('telekasten').goto_thisweek()<CR>", { desc = "To this week" })
      vim.keymap.set(
        "n",
        "<leader>kW",
        ":lua require('telekasten').find_weekly_notes()<CR>",
        { desc = "Find weekly note" }
      )
      vim.keymap.set("n", "<leader>kn", ":lua require('telekasten').new_note()<CR>", { desc = "New note" })
      vim.keymap.set(
        "n",
        "<leader>kN",
        ":lua require('telekasten').new_templated_note()<CR>",
        { desc = "New templated note" }
      )
      vim.keymap.set("n", "<leader>ky", ":lua require('telekasten').yank_notelink()<CR>", { desc = "Yank note link" })
      vim.keymap.set("n", "<leader>kc", ":lua require('telekasten').show_calendar()<CR>", { desc = "Show calendar" })
      vim.keymap.set("n", "<leader>kC", ":CalendarT<CR>", { desc = "Show calendar tab" })
      vim.keymap.set("n", "<leader>kb", ":lua require('telekasten').show_backlinks()<CR>", { desc = "Show backlinks" })
      vim.keymap.set(
        "n",
        "<leader>kF",
        ":lua require('telekasten').find_friends()<CR>",
        { desc = "Find others with link" }
      )
      vim.keymap.set("n", "<leader>#", ":lua require('telekasten').show_tags()<CR>", { desc = "Show tags" })

      vim.keymap.set("i", "[[", "<ESC>:lua require('telekasten').insert_link({ i=true })<CR>")
    end,
  },
}
