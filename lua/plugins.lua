-- Plugins Setups
-- The more significant chunks of configs are in the plugins subdir, leaving
-- only the minor components here.

---@diagnostic disable: missing-fields
local safe_require = require('lib.meta').safe_require

safe_require('plugins.noice')
safe_require('plugins.telescope')
safe_require('plugins.treesitter')
safe_require('plugins.rainbow')
safe_require('plugins.zen')
safe_require('plugins.highlights')

safe_require('ufo').setup({
  provider_selector = function(_, _, _)
    return {'treesitter', 'indent'}
  end
})

-- signify
vim.g.signify_sign_change = '┃'
vim.g.signify_sign_add = '┃'
vim.g.signify_sign_delete_first_line = '▔'
vim.g.signify_sign_delete_change = '┃'
vim.g.signify_sign_delete_change_delete = '┣'
vim.g.signify_vcs_cmds = {
  perforce = 'env DIFF=%d" -U0" citcdiff %f || [[ $? == 1 ]]',
  git = 'git diff --no-color --no-ext-diff -U0 -- %f',
  hg = 'hg diff --color=never --config aliases.diff= --nodates -U0 -- %f'
}

-- changes
vim.g.changes_add_sign = '┃'
vim.g.changes_delete_sign = '┃'
vim.g.changes_modified_sign = '┃'

-- gutentags
vim.g.gutentags_cache_dir                = os.getenv("HOME") .. "/.vim/tags"
-- custom tag file list using fd; see rest of dotfiles
vim.g.gutentags_file_list_command        = "gutentagger"
vim.g.gutentags_resolve_symlinks         = 1
vim.g.gutentags_define_advanced_commands = 1

-- IME switching based on context
if vim.fn.has('macunix') then
  vim.g.macosime_cjk_ime = 'com.sogou.inputmethod.sogou.pinyin'
end
