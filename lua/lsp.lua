-- LSP configurations

---@diagnostic disable: missing-fields
local safe_require = require('lib.meta').safe_require

local cmp = safe_require('cmp')
local lsp_zero = safe_require('lsp-zero').preset({})
local cmp_action = safe_require('lsp-zero').cmp_action()
local capabilities = safe_require('cmp_nvim_lsp').default_capabilities()
local cmp_autopairs = safe_require('nvim-autopairs.completion.cmp')
local lspconfig = safe_require('lspconfig')
local lspkind = safe_require('lspkind')

vim.g.vsnip_snippet_dir = "~/.vim/snippets"

-- LSP Zero presets
-- lsp_zero.extend_lspconfig()
lsp_zero.on_attach(function(_, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions

  -- K: display hover
  -- gd: go to definition
  -- gD: go to declaration
  -- gi: list all implementations
  -- go: go to type definition
  -- gr: list all references
  -- gs: show signature info
  lsp_zero.default_keymaps({ buffer = bufnr })
end)

-- wrap up setup
lsp_zero.setup()

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- theoretically, lsp-zero setups the following for us
cmp.setup({
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
    { name = 'cmdline' },
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
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50,   -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      -- can also be a function to dynamically calculate max width such as
      -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
      ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      show_labelDetails = true, -- show labelDetails in menu. Disabled by default
    })
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
  },
})

-- lang specific
cmp.setup.filetype('sh', {
  sources = cmp.config.sources({
    { name = 'cmdline' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    { name = 'path' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    { name = 'vsnip' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  })
})

-- autopair
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

-- python
lspconfig.pyright.setup {
  capabilities = capabilities,
}

-- lua
lspconfig.lua_ls.setup {
  capabilities = capabilities,
}

-- markdown
lspconfig.marksman.setup {
  capabilities = capabilities,
}

-- symbols
vim.fn.sign_define('DiagnosticSignError', { text = 'x', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '!', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '?', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
