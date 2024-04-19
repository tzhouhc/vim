local c = require('commander')

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
  { name = "Edit Working Directory as Buffer", com = ":Oil --float<cr>" },
}

for _, com in pairs(table) do
  if type(com) == 'table' then
    if com['com'] ~= nil then
      c.add({ makeSimple(com['name'], com['com']) }, { cat = com['cat'] or 'Tools' })
    else
      c.add({ makeSimple(com['name'], com['name']) }, { cat = com['cat'] or 'Tools' })
    end
  else
    c.add({ makeSimple(com, com) }, { cat = 'Tools' })
  end
end
