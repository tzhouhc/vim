-- Completion configurations

---@diagnostic disable: missing-fields

local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local lspkind = require("lspkind")

table.unpack = table.unpack or unpack

local has_words_before = function()
  local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "vsnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
    { name = "calc" },
  }, {
    { name = "emoji" },
    { name = "nerdfont" },
  }),
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    -- format = lspkind.cmp_format({
    --   mode = "symbol", -- show only symbol annotations
    --   maxwidth = 50,   -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    --   -- can also be a function to dynamically calculate max width such as
    --   -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
    --   ellipsis_char = "...",    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
    --   show_labelDetails = true, -- show labelDetails in menu. Disabled by default
    -- }),
    format = function(entry, vim_item)
      local highlights_info = require("colorful-menu").cmp_highlights(entry)

      -- highlight_info is nil means we are missing the ts parser, it's
      -- better to fallback to use default `vim_item.abbr`. What this plugin
      -- offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
      if highlights_info ~= nil then
        vim_item.abbr_hl_group = highlights_info.highlights
        vim_item.abbr = highlights_info.text
      end

      return vim_item
    end,
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      local has_words = has_words_before()
      -- enables typing multiple tabs even if autocomplete already triggered.
      -- why the hell is autocomplete triggering on empty stuff though?
      if cmp.visible() and has_words then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable,
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Up>"] = cmp.mapping(function(fallback)
      local has_words = has_words_before()
      -- enables typing multiple tabs even if autocomplete already triggered.
      -- why the hell is autocomplete triggering on empty stuff though?
      if cmp.visible() and has_words then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<Down>"] = cmp.mapping(function(fallback)
      local has_words = has_words_before()
      -- enables typing multiple tabs even if autocomplete already triggered.
      -- why the hell is autocomplete triggering on empty stuff though?
      if cmp.visible() and has_words then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  },
})

-- lang specific
cmp.setup.filetype("sh", {
  sources = cmp.config.sources({
    { name = "path" },
    { name = "vsnip" },
  }),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

cmp.setup.cmdline({ ':H' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'cmp_help_tags' },
  }
})

-- autopair
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
