return {
  {
    "nvzone/menu",
    dependencies = {
      "nvzone/volt",
      "Mr-LLLLL/interestingwords.nvim",
    },
    config = function()
      local ms = require("lib.plugin.menu")
      vim.keymap.set("n", "g<space>", function()
        require("menu").open(ms.normal)
      end, { silent = true, noremap = true })
      vim.keymap.set("v", "g<space>", function()
        require("menu").open(ms.visual)
      end, { silent = true, noremap = true })
    end,
  },
}
