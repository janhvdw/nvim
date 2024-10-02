return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping = cmp.mapping.preset.insert({
        ["<c-l"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
        }),
        ["<c-h>"] = cmp.mapping.abort(),
        ["<C-j>"] = cmp.mapping.select_next_item({
          behavior = cmp.ConfirmBehavior.Insert,
        }),
        ["<C-k>"] = cmp.mapping.select_prev_item({
          behavior = cmp.ConfirmBehavior.Insert,
        }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
      })
      return opts
    end,
  },
  -- {
  --   "L3MON4D3/LuaSnip",
  --   keys = function()
  --     return {
  --       {
  --         "<C-O>",
  --         function()
  --           local luasnip = require("luasnip")
  --           vim.print("expand_or_jumpable" .. luasnip.expand_or_jumpable())
  --           if luasnip.expand_or_jumpable() then
  --             return luasnip.expand_or_jump(1)
  --           end
  --         end,
  --         expr = true,
  --         silent = true,
  --         mode = { "i", "s" },
  --       },
  --       {
  --         "<C-I>",
  --         function()
  --           local luasnip = require("luasnip")
  --           if luasnip.jumpable then
  --             require("luasnip").jump(-1)
  --           end
  --         end,
  --         mode = { "i", "s" },
  --       },
  --     }
  --   end,
  -- },
}
