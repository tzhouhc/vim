local regex_langs = {
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
}

return {
  -- multiple cursors
  {
    "mg979/vim-visual-multi",
    lazy = false,
    init = function()
      vim.g.VM_maps = {
        ["Select Cursor Down"] = "<M-Down>", -- start selecting down
        ["Select Cursor Up"]   = "<M-Up>",   -- start selecting up
        ["Select Operator"]    = "",
        ["Goto Next"]          = "}",
        ["Goto Prev"]          = "{",
      }
    end,
    config = function()
      vim.g.VM_mouse_mappings = 1
      vim.cmd [[VMDebug]] -- fixes the  ctrl+n in visuala mode
    end,
  },
  -- unto tree
  { "mbbill/undotree",       cmd = "UndotreeToggle" },
  -- regex explainer
  {
    "bennypowers/nvim-regexplainer",
    ft = regex_langs,
    opts = {
      mode = "narrative",
      -- automatically show the explainer when the cursor enters a regexp
      auto = false,

      -- filetypes (i.e. extensions) in which to run the autocommand
      filetypes = regex_langs,

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
    cmd = { "RegexplainerToggle", "RegexplainerShow" },
  },
  -- floating terminal
  { "voldikss/vim-floaterm", cmd = { "FloatermNew", "FloatermToggle" } },
  -- bulk find/replace tool
  {
    "MagicDuck/grug-far.nvim",
    config = true,
    cmd = "GrugFar",
  },
}
