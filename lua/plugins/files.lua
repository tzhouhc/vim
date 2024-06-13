return {
  {
    -- editing filesystem like a buffer
    "stevearc/oil.nvim",
    opts = {},
    config = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Oil",
  },
  {
    -- file system sidebar
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    opts = {
      update_focused_file = {
        enable = true,
        -- tries to stay within the same project where possible
        update_root = {
          enable = false,
        },
      },
    },
  },
}
