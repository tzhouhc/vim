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
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      'nvimtools/hydra.nvim',
    },
    opts = {},
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    keys = {
      {
        mode = { 'v', 'n' },
        '<c-n>',
        '<cmd>MCstart<cr>',
        desc = 'Create a selection for selected text or word under the cursor',
      },
    },
  },
  -- unto tree
  { "mbbill/undotree", cmd = "UndotreeToggle" },
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
  -- bulk find/replace tool
  {
    "MagicDuck/grug-far.nvim",
    config = true,
    cmd = "GrugFar",
  },
  {
    "dhananjaylatkar/cscope_maps.nvim",
    opts = {
      -- maps related defaults
      disable_maps = false,   -- "true" disables default keymaps
      skip_input_prompt = false, -- "true" doesn't ask for input
      prefix = "<leader>c",   -- prefix to trigger maps

      -- cscope related defaults
      cscope = {
        -- location of cscope db file
        db_file = "./cscope.out", -- DB or table of DBs
        -- NOTE:
        --   when table of DBs is provided -
        --   first DB is "primary" and others are "secondary"
        --   primary DB is used for build and project_rooter
        -- cscope executable
        exec = "cscope",                   -- "cscope" or "gtags-cscope"
        -- choose your fav picker
        picker = "quickfix",               -- "quickfix", "telescope", "fzf-lua" or "mini-pick"
        -- size of quickfix window
        qf_window_size = 5,                -- any positive integer
        -- position of quickfix window
        qf_window_pos = "bottom",          -- "bottom", "right", "left" or "top"
        -- "true" does not open picker for single result, just JUMP
        skip_picker_for_single_result = false, -- "false" or "true"
        -- these args are directly passed to "cscope -f <db_file> <args>"
        db_build_cmd = { args = { "-bqkv" } },
        -- statusline indicator, default is cscope executable
        statusline_indicator = nil,
        -- try to locate db_file in parent dir(s)
        project_rooter = {
          enable = false, -- "true" or "false"
          -- change cwd to where db_file is located
          change_cwd = false, -- "true" or "false"
        },
      }
    }
  }
}
