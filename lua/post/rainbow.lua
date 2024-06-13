local mix_colors = require("lib.colors").mix_colors

local M = {}

-- rainbow delimiters
M.rainbow_colors = {
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

-- default background color for nord theme
local bg = "#2E3440"

-- mix each color from `colors` with `bg`. `bright` determines how much original
-- color there is compared to the darker `bg`.
local make_rainbow = function(colors, prefix, bright)
	local out = {}
	for i, color in ipairs(colors) do
		local darker = mix_colors(color, bg, bright)
		vim.api.nvim_set_hl(0, prefix .. i, { fg = darker })
		table.insert(out, prefix .. i)
	end
	return out
end

-- vanilla version of the colors
M.rainbow_groups = make_rainbow(M.rainbow_colors, "RainbowDelim", 1)

-- slightly dim variant for less sharp colors
M.rainbow_dim_groups = make_rainbow(M.rainbow_colors, "RainbowDimDelim", 0.85)

-- significantly darker variant
M.rainbow_dark_groups = make_rainbow(M.rainbow_colors, "RainbowDarkDelim", 0.3)

vim.g.rainbow_delimiters = {
	highlight = M.rainbow_dim_groups,
	blacklist = {
		"dashboard",
	},
}

-- ibl
local hooks = require("ibl.hooks")
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	make_rainbow(M.rainbow_colors, "RainbowDelim", 1)
	make_rainbow(M.rainbow_colors, "RainbowDarkDelim", 0.3)
end)

require("ibl").setup({
	indent = {
		char = "┇",
		highlight = M.rainbow_dark_groups,
	},
	exclude = { filetypes = { "dashboard" } },
	scope = { char = "┇", highlight = M.rainbow_groups },
})

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

return M
