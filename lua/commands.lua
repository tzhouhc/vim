local c = require('commander')

c.add({
  {
    desc = "Unfold All",
    cmd = "zR",
  },
  {
    desc = "Fold To Top",
    cmd = "zM",
  },
}, {
  cat = "Folding",
})

c.add({
  {
    desc = "Edit Working Directory as Buffer",
    cmd = ":Oil --float<cr>",
  },
}, {
  cat = "Tools",
})

local function makeSimple (name, com)
  return {
    desc = name,
    cmd = ":" .. com .. "<cr>",
  }
end

local direct_calls = {
  "SymbolsOutline",
  "Telescope",
  "Twilight",
  "Nerdy",
  "Lazy",
  "Trouble",
  "Mason",
  { name = 'Colorizer', com = 'ColorizerToggle' }
}

for _, com in pairs(direct_calls) do
  if type(com) == 'table' then
    c.add({makeSimple(com['name'], com['com'])}, {cat='Tools'})
  else
    c.add({makeSimple(com, com)}, {cat='Tools'})
  end
end
