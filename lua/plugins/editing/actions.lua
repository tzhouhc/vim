-- high level logic:
-- <space> would be used to make these sort of edits that are slightlys
-- sophisticated to do manually but also not quite as trivial as can be done
-- using regular keystrokes.

return {
  {
    -- quickly expand or compactify a dict/list/set/...
    "Wansmer/treesj",
    keys = { "<space>m", "<space>j", "<space>s" },
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
    config = true,
  },
}
