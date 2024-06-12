-- overall status column config
-- relative line number, sign column, custom folding, spacer
vim.o.statuscolumn =
	'%=%{v:relnum?v:relnum:v:lnum}%s%{foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "" : "") : " "} '

-- folding
require("ufo").setup({
	provider_selector = function(_, _, _)
		return { "treesitter", "indent" }
	end,
})

-- signify
vim.g.signify_sign_change = "┃"
vim.g.signify_sign_add = "┃"
vim.g.signify_sign_delete_first_line = "▔"
vim.g.signify_sign_delete_change = "┃"
vim.g.signify_sign_delete_change_delete = "┣"
vim.g.signify_vcs_cmds = {
	perforce = 'env DIFF=%d" -U0" citcdiff %f || [[ $? == 1 ]]',
	git = "git diff --no-color --no-ext-diff -U0 -- %f",
	hg = "hg diff --color=never --config aliases.diff= --nodates -U0 -- %f",
}

-- changes
vim.g.changes_add_sign = "┃"
vim.g.changes_delete_sign = "┃"
vim.g.changes_modified_sign = "┃"

-- scrollbar -- sure, on the right, but still sort of like a sign column :)
require("scrollbar").setup({
	show_in_active_only = true,
	hide_if_all_visible = true, -- Hides everything if all lines are visible
	excluded_buftypes = {
		"terminal",
	},
	excluded_filetypes = {
		"",
		"cmp_docs",
		"cmp_menu",
		"noice",
		"prompt",
		"TelescopePrompt",
	},
})
