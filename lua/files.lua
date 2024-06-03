local safe_require = require("lib.meta").safe_require

vim.filetype.add({
	extension = {
		nu = "nu",
	},
	filename = {
		["justfile"] = "just",
		[".justfile"] = "just",
		[".notes"] = "markdown",
	},
})
