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
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    event = "VeryLazy",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      local set = vim.keymap.set

      -- Add or skip cursor above/below the main cursor.
      set({ "n", "x" }, "<m-up>", function() mc.lineAddCursor(-1) end)
      set({ "n", "x" }, "<m-down>", function() mc.lineAddCursor(1) end)
      set({ "n", "x" }, "<leader-up>", function() mc.lineSkipCursor(-1) end)
      set({ "n", "x" }, "<leader-down>", function() mc.lineSkipCursor(1) end)

      -- Add or skip adding a new cursor by matching word/selection
      set({ "n", "x" }, "<c-n>", function() mc.matchAddCursor(1) end)

      -- Disable and enable cursors.
      set({ "n", "x" }, "<c-q>", mc.toggleCursor)

      -- Mappings defined in a keymap layer only apply when there are
      -- multiple cursors. This lets you have overlapping mappings.
      mc.addKeymapLayer(function(layerSet)
        -- Select a different cursor as the main one.
        layerSet({ "n", "x" }, "<m-left>", mc.prevCursor)
        layerSet({ "n", "x" }, "<m-right>", mc.nextCursor)

        -- Delete the main cursor.
        layerSet({ "n", "x" }, "<c-x>", mc.deleteCursor)

        -- Enable and clear cursors using escape.
        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { reverse = true })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn" })
      hl(0, "MultiCursorMatchPreview", { link = "Search" })
      hl(0, "MultiCursorDisabledCursor", { reverse = true })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end
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
}
