-- in markdown, comment leaders are '*'s and such; it would not
-- be good to reinsert them automatically.
-- yet, we still want to make sure that if we *manually* breaking the line by
-- using either `Enter` or `o` or `O`, that we do indeed get another bullet
-- point. I.e. we only want a new line when we *ask* for it.
vim.bo.autoindent = true
vim.bo.formatoptions = "crnojqw"

-- set conceallevel=2
-- set concealcursor=nc
vim.bo.tw = 80
vim.bo.wrapmargin = 0
vim.bo.formatoptions = vim.bo.formatoptions .. "t"
vim.wo.linebreak = true
vim.bo.spelllang = "en"
