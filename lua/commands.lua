local c = require('commander')

-- c.add({
--   {
--     desc = "Symbols Outline",
--     cmd = ":SymbolsOutline<cr>",
--   },
--   {
--     desc = "Telescope",
--     cmd = ":Telescope<cr>",
--   },
-- }, {
--   cat = "Tools",
-- })

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
