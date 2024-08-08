return {
  -- tools
  -- multiple cursors
  "mg979/vim-visual-multi",
  -- unto tree
  { "mbbill/undotree",        cmd = "UndotreeToggle" },
  -- custom commands
  { "FeiyouG/commander.nvim", config = true,         keys = { { "<m-space>", "n" } } },
  -- regex explainer
  {
    "bennypowers/nvim-regexplainer",
    opts = {
      mode = "narrative",
      -- automatically show the explainer when the cursor enters a regexp
      auto = true,

      -- filetypes (i.e. extensions) in which to run the autocommand
      filetypes = {
        "html",
        "js",
        "cjs",
        "mjs",
        "ts",
        "jsx",
        "tsx",
        "cjsx",
        "mjsx",
        "py",
        "sh",
      },

      -- Whether to log debug messages
      debug = false,

      -- 'split', 'popup'
      display = "popup",

      mappings = {
        toggle = "gR",
        -- examples, not defaults:
        -- show = 'gS',
        -- hide = 'gH',
        -- show_split = 'gP',
        -- show_popup = 'gU',
      },

      narrative = {
        separator = "\n",
      },
    },
  },
  -- floating terminal
  { "voldikss/vim-floaterm", cmd = "FloatermNew" },
  {
    'MagicDuck/grug-far.nvim',
    config = true,
    cmd = "GrugFar",
  },
}
