return {
  {
    -- editing filesystem like a buffer
    "stevearc/oil.nvim",
    opts = {},
    config = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Oil",
  },
  -- file explorer
  {
    "mikavilpas/yazi.nvim",
    config = true,
    cmd = { "Yazi" },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    cmd = { "Neotree" },
    lazy = false, -- neo-tree will lazily load itself
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
      -- fill any relevant options here
    },
    config = function ()
      vim.keymap.set("n", "<leader>nt", "<cmd>Neotree<cr>", {})
    end
  }
}
