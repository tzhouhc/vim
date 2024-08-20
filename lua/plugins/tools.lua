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
        ["Select Cursor Down"] = "<M-Down>",   -- start selecting down
        ["Select Cursor Up"]   = "<M-Up>",     -- start selecting up
        ["Add Cursor At Pos"]  = "<M-Space>",  -- start selecting here
        ["Select Operator"]    = "",
        ["Goto Next"]          = "}",
        ["Goto Prev"]          = "{",
      }
      -- Hack around issue with conflicting insert mode <BS> mapping
      -- between this plugin and nvim-autopairs
      vim.api.nvim_create_autocmd('User', {
        pattern = 'visual_multi_start',
        callback = function()
          pcall(vim.keymap.del, 'i', '<BS>', { buffer = 0 })
        end,
      })
      vim.api.nvim_create_autocmd('User', {
        pattern = 'visual_multi_exit',
        callback = function()
          require('nvim-autopairs').force_attach()
        end,
      })
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
