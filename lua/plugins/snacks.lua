return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      image = {
        doc = {
          inline = false,
          float = true,
        },
        resolve = function(path, src)
          if require("obsidian.api").path_is_note(path) then
            return require("obsidian.api").resolve_image_path(src)
          end
        end,
      },
    },
  },
}
