local iw = require("interestingwords")
local edit = require("lib.editing")
local term = require("lib.plugin.snacks")

local M = {}

M.normal = {
  -- first section
  {
    name = "󰈭 Highlight Word",
    cmd = function()
      iw.InterestingWord("n", false)
      iw.InterestingWord("n", true)
    end,
  },
  {
    name = "󰍉 Inspect",
    cmd = "Inspect",
  },
  {
    name = " Lookup",
    cmd = function()
      local w = edit.get_word_under_cursor()
      if w then
        term.dictionary(w)
      end
    end,
  },
  { name = "separator" },
  {
    name = "󰍉 Go to Definition",
    cmd = vim.lsp.buf.definition,
  },
}

M.visual = {
  -- first section
  {
    name = "󰈭 Highlight Word",
    cmd = function()
      iw.InterestingWord("v", false)
      iw.InterestingWord("v", true)
    end,
  },
  {
    name = " Lookup",
    cmd = function()
      local w = edit.get_word_under_cursor()
      if w then
        term.dictionary(w)
      end
    end,
  },
  { name = "separator" },
  {
    name = "󰉼 Format",
    cmd = "FormatCode",
  },
}

return M
