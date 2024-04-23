-- Command Palette Customizations

local safe_require = require('lib.meta').safe_require

-- Custom Commands
local scopes = safe_require('lib.scopes')
local misc = safe_require('lib.misc')

vim.api.nvim_create_user_command('Runtimes', scopes.runtime_files, {})
vim.api.nvim_create_user_command('VimConfigs', scopes.find_configs, {})
vim.api.nvim_create_user_command('Dotfiles', scopes.find_dotfiles, {})
vim.api.nvim_create_user_command('Snippets', scopes.find_snippets, {})

vim.api.nvim_create_user_command('Marks', safe_require('telescope.builtin').marks, {})

vim.api.nvim_create_user_command('GetPluginLink', misc.get_current_line_plugin, {})

-- Commander
local c = safe_require('commander')

local function makeSimple(name, com)
  return {
    desc = name,
    cmd = com
  }
end

local commands_table = {
  "Runtimes",
  "Twilight",
  "Nerdy",
  "Lazy",
  "Trouble",
  "Mason",
  "ZenMode",
  "Marks",
  { "Unfold All",                       com = "zR",                                   cat = "Folding" },
  { "Fold All",                         com = "zM",                                   cat = "Folding" },
  { "Vim Configs",                      com = "<CMD>VimConfigs<cr>",                  cat = "Configs" },
  { "Dot files",                        com = "<CMD>Dotfiles<cr>",                    cat = "Configs" },
  { "Snippet files",                    com = "<CMD>Snippets<cr>",                    cat = "Configs" },
  { "Ctags Config",                     com = "<CMD>e ~/.dotfiles/configs/ctags<cr>", cat = "Configs" },
  { "Symbols Outline",                  com = "<CMD>SymbolsOutline<cr>" },
  { "Format Code",                      com = "<CMD>LspZeroFormat<cr>" },
  { "File Tree",                        com = "<CMD>NvimTreeToggle<cr>" },
  { 'Colorizer',                        com = "<CMD>ColorizerToggle<cr>" },
  { "Edit Working Directory as Buffer", com = "<CMD>Oil --float<cr>" },
  { "Telescope",                        com = "<CMD>Telescope<cr>" },
  { "Tags",                             com = "<CMD>Telescope tags<cr>" },
  { "Registers",                        com = "<CMD>Telescope registers<cr>" },
}

for _, com in pairs(commands_table) do
  if type(com) == 'table' then
    local name = com[1]
    local cat = com['cat'] or 'Tools'
    local command = com['com'] or name
    c.add({ makeSimple(name, command) }, { cat = cat })
  else
    c.add({ makeSimple(com, ":" .. com .. "<cr>") }, { cat = 'Tools' })
  end
end
