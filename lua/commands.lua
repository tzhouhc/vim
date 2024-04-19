-- Command Palette Customizations

local safe_require = require('lib.meta').safe_require
local c = safe_require('commander')

local function makeSimple(name, com)
  return {
    desc = name,
    cmd = ":" .. com .. "<cr>",
  }
end

local table = {
  "SymbolsOutline",
  "Runfiles",
  "Telescope",
  "Twilight",
  "Nerdy",
  "Lazy",
  "Trouble",
  "Mason",
  { name = "File Tree", com = "NvimTreeToggle" },
  { name = "VimConfigs", cat = "Configs" },
  { name = "Dotfiles", cat = "Configs" },
  { name = "Ctags Config", com = "e ~/.dotfiles/configs/ctags<cr>", cat = "Configs" },
  { name = "Unfold All", com = "zR", cat = "Folding" },
  { name = "Fold All", com = "zM", cat = "Folding" },
  { name = 'Colorizer', com = 'ColorizerToggle' },
  { name = "Edit Working Directory as Buffer", com = "Oil --float<cr>" },
}

for _, com in pairs(table) do
  if type(com) == 'table' then
    local cat = com['cat'] or 'Tools'
    local command = com['com'] or com['name']
    c.add({ makeSimple(com['name'], command) }, { cat = cat })
  else
    c.add({ makeSimple(com, com) }, { cat = 'Tools' })
  end
end
