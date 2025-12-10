local events = { "BufReadPost", "BufNewFile", "BufWritePre" }
local cmplib = require("lib.plugin.blink")

local keymap = {
  ["<c-c>"] = { "cancel" },
  ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
  ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
  ["<CR>"] = { "accept", "fallback" },
}
if vim.g.escape_clears_cmp then
  keymap["<esc>"] = {
    cmplib.cancel_and_exit,
    "fallback",
  }
  keymap["<S-CR>"] = { cmplib.accept_and_exit, "fallback" }
end

return {
  -- color rendering of completion labels
  "xzbdmw/colorful-menu.nvim",
  -- completion sources
  -- completion engine
  {
    "saghen/blink.cmp",
    event = events,
    version = "1.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "mgalliou/blink-cmp-tmux",
    },
    -- build = 'cargo build --release',
    config = function()
      require("blink.cmp").setup({
        enabled = function()
          return require("lib.ft").is_normal_buffer(0)
        end,
        signature = { enabled = true },
        completion = {
          accept = {
            auto_brackets = { enabled = true },
          },
          keyword = { range = "full" },
          -- Show documentation when selecting a completion item
          documentation = { auto_show = true, auto_show_delay_ms = 500 },
          -- Display a preview of the selected item on the current line
          ghost_text = { enabled = true },

          -- rendering of the actual completion menu
          menu = {
            draw = {
              cursorline_priority = 5000,
              padding = { 0, 1 },
              columns = { { "kind_icon", "kind" }, { "label", gap = 1 }, { "source_name" } },
              components = {
                kind_icon = {
                  text = cmplib.kind_icon_text,
                },
                kind = {
                  text = cmplib.kind_text,
                  highlight = cmplib.kind_highlight,
                },
                label = {
                  width = { fill = true, max = 60 },
                  text = cmplib.label_text,
                  highlight = cmplib.label_highlight,
                },
              },
            },
          },
          list = {
            selection = {
              preselect = false,
              auto_insert = true,
            },
          },
        },
        sources = {
          default = cmplib.select_cmp_sources,
          providers = {
            buffer = {
              opts = {
                -- or (recommended) filter to only "normal" buffers
                get_bufnrs = cmplib.all_bufnrs,
              },
            },
            tmux = {
              module = "blink-cmp-tmux",
              name = "tmux",
              -- default options
              opts = {
                all_panes = true,
                capture_history = true,
                -- only suggest completions from `tmux` if the `trigger_chars` are
                -- used
                triggered_only = false,
                trigger_chars = { "." },
              },
            },
          },
        },
        fuzzy = {
          implementation = "prefer_rust",
        },
        keymap = keymap,
        cmdline = {
          sources = cmplib.cmd_sources,
          completion = {
            list = {
              selection = {
                preselect = false,
                -- When `true`, inserts the completion item automatically when selecting it
                auto_insert = true,
              },
            },
            menu = { auto_show = true },
          },
        },
      })

      -- customize help command prefix check -- we use 'H' instead of 'h'
      local consts = require("blink.cmp.sources.cmdline.constants")
      consts.help_commands = {
        help = true,
        hel = true,
        he = true,
        h = true, -- these are not actually needed since h gets turned into H anyway
        H = true,
      }

      local colors = require("lib.colors")

      -- Create bg color for each completion kind, asd
      local bg = colors.bg_by_hlgroup("Pmenu")
      if not bg then
        return
      end

      -- completion colors
      for _, name in pairs(vim.fn.getcompletion("BlinkCmpKind*", "highlight")) do
        local fg = colors.fg_by_hlgroup(name)
        if fg then
          vim.api.nvim_set_hl(0, name, { bg = fg, fg = bg })
        end
      end

      vim.api.nvim_set_hl(0, "BlinkCmpKindText", { bg = bg, fg = colors.fg_by_hlgroup("BlinkCmpLabel") })
      vim.api.nvim_set_hl(0, "BlinkCmpKindSnippet", { bg = bg, fg = colors.fg_by_hlgroup("BlinkCmpLabel") })
    end,
  },
}
