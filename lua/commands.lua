-- Command Palette Customizations

local safe_require = require('lib.meta').safe_require
local c = safe_require('commander')

local function makeSimple(name, com)
  return {
    desc = name,
    cmd = com
  }
end

local commands_table = {
  "Runtimes",
  "Telescope",
  "Twilight",
  "Nerdy",
  "Lazy",
  "Trouble",
  "Mason",
  { "Unfold All",                       com = "zR",                          cat = "Folding" },
  { "Fold All",                         com = "zM",                          cat = "Folding" },
  { "Symbols Outline",                  com = "<CMD>SymbolsOutline<cr>" },
  { "Format Code",                      com = "<CMD>LspZeroFormat<cr>" },
  { "File Tree",                        com = "<CMD>NvimTreeToggle<cr>" },
  { "Vim Configs",                      com = "<CMD>VimConfigs<cr>",                  cat = "Configs" },
  { "Dot files",                        com = "<CMD>Dotfiles<cr>",                    cat = "Configs" },
  { "Ctags Config",                     com = "<CMD>e ~/.dotfiles/configs/ctags<cr>", cat = "Configs" },
  { 'Colorizer',                        com = "<CMD>ColorizerToggle<cr>" },
  { "Edit Working Directory as Buffer", com = "<CMD>Oil --float<cr>" },
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
    c.add({ makeSimple(com, ":"..com.."<cr>") }, { cat = 'Tools' })
  end
end
