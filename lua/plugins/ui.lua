return {
  -- visuals
  -- startup page
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  -- create vertical lines to mark indentation.
  "lukas-reineke/indent-blankline.nvim",
  -- rainbow colors for parentheses/brackets for easier depth determination
  "HiPhish/rainbow-delimiters.nvim",
  -- highlight hex colors
  { "norcalli/nvim-colorizer.lua", config = true, cmd = "ColorizerToggle" },

  -- custom sign column
  { "luukvbaal/statuscol.nvim" },

  -- highlight TODOs
  { "folke/todo-comments.nvim",    config = true },
  -- smart dimming of unrelated contextual code
  { "folke/twilight.nvim",         config = true, cmd = "Twilight" },
  -- keep top of code context on screen when scrolling past
  "nvim-treesitter/nvim-treesitter-context",
  -- text objects
  "nvim-treesitter/nvim-treesitter-textobjects",
  -- highlight same token as the cursor is currently hovering over
  "RRethy/vim-illuminate",
  -- smarter folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    opts = {
      provider_selector = function(_, _, _)
        return { "treesitter", "indent" }
      end,
    },
  },
  -- navic
  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
    config = true,
  },
  -- status bar
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "meuter/lualine-so-fancy.nvim" },
  },
}
