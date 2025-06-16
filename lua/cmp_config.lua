local luasnip = require("luasnip")
local cmp = require("cmp")
local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },

  sources = {
    { name = 'path' },
    { name = 'luasnip',       keyword_length = 2 },
    { name = 'nvim_lsp',      keyword_length = 1 },
    { name = 'lsp_signature', keyword_length = 1 },
    { name = 'buffer',        keyword_length = 3 },
  },
  sorting = {
    comparators = {
      function(entry1, entry2)
        local kind1 = entry1:get_kind()
        local kind2 = entry2:get_kind()
        if kind1 == kind2 then
          return nil
        end
        if kind1 == 20 then
          return true;
        elseif kind2 == 20 then
          return false;
        end

        return nil
      end,
      cmp.config.compare.score,
      cmp.config.compare.exact,
      cmp.config.compare.offset,
      cmp.config.compare.sort_text,
      cmp.config.compare.kind,
      cmp.config.compare.recently_used,
    }
  },
  formatting = {
    fields = { 'abbr', 'menu', 'kind' },
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = '(lsp)',
        luasnip = '(snip)',
        buffer = '(buffer)',
        lsp_signature = '(signature)',
        path = '(path)',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),

    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

  },
  window = {
    documentation = cmp.config.window.bordered()
  },
})
