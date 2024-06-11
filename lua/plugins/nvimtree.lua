local safe_require = require('lib.meta').safe_require
local nvimtree = require("nvim-tree")
nvimtree.setup({
  update_focused_file = {
    enable = true,
    -- tries to stay within the same project where possible
    update_root = {
      enable = false,
    }
  }
})
