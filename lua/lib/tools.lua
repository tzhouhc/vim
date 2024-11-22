local M = {}

function M.smart_format(opts)
	if opts.range == 0 then
		require("conform").format({ lsp_format = "prefer", async = true })
	else
		require("conform").format({
			lsp_format = "prefer",
			async = true,
			range = {
				start = { opts.line1, 0 },
				["end"] = { opts.line2, 0 },
			}
		})
	end
end

return M
