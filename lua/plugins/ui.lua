return {
  -- visuals
  -- startup page
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  -- transparent background
  {
    "xiyaowong/transparent.nvim",
    opts = {
      extra_groups = { "ColorColumn" }
    }
  },
  -- create vertical lines to mark indentation.
  "lukas-reineke/indent-blankline.nvim",
  -- rainbow colors for parentheses/brackets for easier depth determination
  "HiPhish/rainbow-delimiters.nvim",
  -- highlight hex colors
  { "norcalli/nvim-colorizer.lua", config = true, cmd = "ColorizerToggle" },

  -- custom sign column
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        -- configuration goes here, for example:
        segments = {
          {
            sign = { namespace = { "diagnostic/signs" }, maxwidth = 1, auto = true },
            click = "v:lua.ScSa"
          },
          {
            text = { builtin.lnumfunc },
            click = "v:lua.ScLa",
          },
          { sign = { namespace = { "gitsigns" }, maxwidth = 1, auto = false } },
          {
            text = { builtin.foldfunc },
            click = "v:lua.ScFa",
          },
        }
      })
    end
  },

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
