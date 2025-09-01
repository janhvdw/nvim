return {
  {
    "3rd/image.nvim",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    filetypes = { "markdown" },
    opts = {
      processor = "magick_cli",
      integrations = {
        markdown = {
          clear_in_insert_mode = true,
          only_render_image_at_cursor = true, -- defaults to false
          only_render_image_at_cursor_mode = "popup", -- "popup" or "inline", defaults to "popup"
          filetypes = { "markdown", "markview" },
        },
      },
    },
  },
  {
    "3rd/diagram.nvim",
    dependencies = {
      "3rd/image.nvim",
    },
    enabled = true,
    filetypes = { "markdown" },
    opts = {
      events = {
        render_buffer = { "InsertLeave", "BufWinEnter", "TextChanged", "FocusGained" },
        clear_buffer = { "InsertEnter", "BufLeave", "FocusLost" },
      },
      -- integrations = {
      --   require("diagram.integrations.markdown"),
      --   require("diagram.integrations.neorg"),
      -- },
      renderer_options = {
        mermaid = {
          theme = "forest",
        },
        plantuml = {
          charset = "utf-8",
        },
        d2 = {
          theme_id = 1,
        },
        gnuplot = {
          theme = "dark",
          size = "800,600",
        },
      },
    },
  },
}
