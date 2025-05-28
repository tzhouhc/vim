-- Configure multiple sets of rainbow colors for use with plugins like rainbow
-- indent and delimiters, etc.

local cs = require("lib.colors")

-- rainbow delimiters
local rainbow_colors = {
  "#F6ED56",
  "#A6C955",
  "#4BA690",
  "#4191C9",
  "#2258A0",
  "#654997",
  "#994D95",
  "#D45196",
  "#DB3A35",
  "#E5783A",
  "#EC943F",
  "#F7C247",
}

-- default background color for *current* theme; needing to fetch this is why
-- this is loaded as part of `post`.
local bg = cs.bg_by_hlgroup("Normal")
assert(bg, "Normal discolored")

-- Create mixed colored hl groups using the given colors,
-- mix each color from `colors` with `bg`. `bright` determines how much original
-- color there is compared to the darker `bg`.
local make_rainbow = function(colors, prefix, bright)
  local out = {}
  for i, color in ipairs(colors) do
    local darker = cs.mix_colors(color, bg, bright)
    vim.api.nvim_set_hl(0, prefix .. i, { fg = darker })
    table.insert(out, prefix .. i)
  end
  return out
end

-- vanilla version of the colors
make_rainbow(rainbow_colors, "RainbowDelim", 1)

-- slightly dim variant for less sharp colors
local rainbow_dim_groups = make_rainbow(rainbow_colors, "RainbowDimDelim", 0.85)

-- significantly darker variant
make_rainbow(rainbow_colors, "RainbowDarkDelim", 0.2)

vim.g.rainbow_delimiters = {
  highlight = rainbow_dim_groups,
  blacklist = {
    "dashboard",
  },
}
