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

local function makeSimple (com)
  return {
    desc = com,
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
}

for _, com in pairs(direct_calls) do
  c.add({makeSimple(com)}, {cat='Tools'})
end
