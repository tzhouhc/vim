-- Utilities for the custom `tasks.md` file.

local M = {}

function M.toggle_todo_item()
	-- assumes the cursor is over a line that looks like these:
	-- - [ ] do some task by mm/dd
	--   - [ ] do some subtask by yyyy/mm/dd
	-- given these format, when we invoke this function with the cursor on one
	-- such line, it should
	-- 1. if there is only space between the [ ], replace the space with `x`; if there
	--    is anything, replace with space.
	-- 2. if replacing space with x, delete the trailing `by ....` in the line.
	--
	local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_get_current_line()

	-- Match the todo pattern; capture spaces and the potential "by ..." at end
	local pattern = "^([%s%-]*)%[([ -?!xX])%](.*)$"
	local prefix, state, rest = line:match(pattern)
	if not prefix then
		return
	end

	if state ~= "x" then
		-- Toggle to checked, remove trailing 'by ...'
		-- Remove 'by ...' (ignore leading/trailing whitespace)
		local content = rest:gsub("%s+by%s+.*$", "")
		line = string.format("%s[x]%s", prefix, content)
	else
		-- Toggle to unchecked, keep remainder
		line = string.format("%s[ ]%s", prefix, rest)
	end

	-- Set the new line back to buffer
	vim.api.nvim_buf_set_lines(0, row - 1, row, false, { line })
end

return M
