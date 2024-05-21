return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
      })
      return opts
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {
        {
          "<C-l>",
          function()
            local luasnip = require("luasnip")
            if luasnip.expand_or_jumpable() then
              return luasnip.expand_or_jump(1)
            end
          end,
          expr = true,
          silent = true,
          mode = { "i", "s" },
        },
        {
          "<C-h>",
          function()
            local luasnip = require("luasnip")
            if luasnip.jumpable then
              require("luasnip").jump(-1)
            end
          end,
          mode = { "i", "s" },
        },
      }
    end,
  },
}
