local M = {}

local function extract_plugin(line)
	-- first string literal in the line
	return line:match("[\"']([^'\"]+)[\"']")
end

function M.dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. M.dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

function M.popup(content)
	require("noice").notify(content, "󰍡")
end

function M.hover(content)
	require("noice").redirect(function()
		print(content) -- always a msg_show event
	end, {
		{
			view = "temp_hover",
			filter = { event = "msg_show" },
		},
	})
end

function M.get_current_line_plugin()
	local line = vim.api.nvim_get_current_line()
	local plugin = extract_plugin(line)
	if vim.fn.has("macunix") then
		-- directly shell out and open the plugin github page
		vim.fn.system("open 'https://github.com/" .. plugin .. "'")
	else
		-- create popup with the link so user can do whatever
		M.popup("https://github.com/" .. plugin)
	end
end

return M
