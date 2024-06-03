local M = {}

function M.lazy_git()
	vim.cmd(
		":FloatermNew --height=0.9 --width=0.9 --wintype=float --title=lazygit --name=LazyGit --autoclose=2 lazygit"
	)
end

function M.yazi()
	vim.cmd(":FloatermNew yazi")
end

return M
