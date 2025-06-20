local iw = require("interestingwords")

local M = {}

M.normal = {
  -- first section
  {
    name = "Highlight Word",
    cmd = function()
      iw.InterestingWord('n', false)
      iw.InterestingWord('n', true)
    end
  },
  {
    name = "Inspect",
    cmd = "Inspect",
  },
  {
    name = "Go to Definition",
    cmd = vim.lsp.buf.definition,
  },
}

M.visual = {
  -- first section
  {
    name = "Highlight Word",
    cmd = function()
      iw.InterestingWord('v', false)
      iw.InterestingWord('v', true)
    end
  },
  {
    name = "Format",
    cmd = "FormatCode",
  }
}

return M
