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
