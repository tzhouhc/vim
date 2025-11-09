-- Overriding neovim default operations

-- Silent annoying deprecation notice triggered by some plugin (probably)
if vim.version().minor >= 11 then
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.deprecate = function() end
end

-- replace nvim native popup menu config as it forces you to accept some of
-- the menu items
vim.api.nvim_del_augroup_by_name("nvim.popupmenu")

-- remove unwanted items from RMB popup menu
vim.cmd("aunmenu PopUp.-2-")
vim.cmd("aunmenu PopUp.How-to\\ disable\\ mouse")
vim.cmd("aunmenu PopUp.Configure\\ Diagnostics")

local function enable_ctx_menu()
  vim.cmd([[
      amenu disable PopUp.Go\ to\ definition
      amenu disable PopUp.Open\ in\ web\ browser
      amenu disable PopUp.Show\ Diagnostics
      amenu disable PopUp.Show\ All\ Diagnostics
    ]])

  local urls = require('vim.ui')._get_urls()
  if vim.startswith(urls[1], 'http') then
    vim.cmd([[amenu enable PopUp.Open\ in\ web\ browser]])
  elseif vim.lsp.get_clients({ bufnr = 0 })[1] then
    vim.cmd([[anoremenu enable PopUp.Go\ to\ definition]])
  end

  local lnum = vim.fn.getcurpos()[2] - 1 ---@type integer
  local diagnostic = false
  if next(vim.diagnostic.get(0, { lnum = lnum })) ~= nil then
    diagnostic = true
    vim.cmd([[anoremenu enable PopUp.Show\ Diagnostics]])
  end

  if diagnostic or next(vim.diagnostic.count(0)) ~= nil then
    vim.cmd([[
        anoremenu enable PopUp.Show\ All\ Diagnostics
      ]])
  end
end

-- adjust nvim native popupmenu configs to avoid errors due to nvim not finding
-- the expected items.
local nvim_popupmenu_augroup = vim.api.nvim_create_augroup('nvim.popupmenu', {})
vim.api.nvim_create_autocmd('MenuPopup', {
  group = nvim_popupmenu_augroup,
  desc = 'Mouse popup menu',
  -- nested = true,
  callback = function()
    enable_ctx_menu()
  end,
})

-- disable newtr
vim.keymap.set("n", "gf", "", {})

-- remote clipboard
if vim.g.ssh then
  local function paste()
    return {
      vim.fn.split(vim.fn.getreg(""), "\n"),
      vim.fn.getregtype(""),
    }
  end
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = paste,
      ['*'] = paste,
    },
  }
end
