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
  }
}

M.visual = {
  -- first section
  {
    name = "Highlight Word",
    cmd = function()
      iw.InterestingWord('v', false)
      iw.InterestingWord('v', true)
    end
  }
}

return M
