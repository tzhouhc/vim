local events = { "BufReadPost", "BufNewFile", "BufWritePre" }

-- Map longer kind names to abbreviations for a nicer looking column.
local kind_map = {
  Variable = "Var ",
  Function = "Func",
  Snippet = "Snip",
  Property = "Prty",
  Keyword = "Kwrd",
  Class = "Cls ",
  Color = "Colr",
  Event = "Evnt",
  Field = "Fld ",
  Value = "Val ",
  Folder = "Fdr ",
  Method = "Mtd ",
  Module = "Mdl ",
  Struct = "Strt",
  Copilot = "Cplt",
  Constant = "Cons",
  Operator = "Oprt",
  Interface = "Intf",
  Reference = "Ref ",
  EnumMember = "Enum",
  Constructor = "Cons",
  TypeParameter = "Type",
}

local comment_types = {
  'comment',
  'comment_content',
  'line_comment',
  'block_comment',
  'string',
  'string_content',
}

local function kind_icon_text(ctx)
  return " " .. ctx.kind_icon .. " "
end

local function kind_text(ctx)
  return (kind_map[ctx.kind] or ctx.kind) .. " "
end

local function kind_highlight(ctx)
  return { { group = ctx.kind_hl, priority = 20000 } }
end

local function label_text(ctx)
  local highlights_info = require("colorful-menu").blink_highlights(ctx)
  if highlights_info ~= nil then
    -- Or you want to add more item to label
    return highlights_info.label
  else
    return ctx.label
  end
end

local function label_highlight(ctx)
  local highlights = {}
  local highlights_info = require("colorful-menu").blink_highlights(ctx)
  if highlights_info ~= nil then
    highlights = highlights_info.highlights
  end
  for _, idx in ipairs(ctx.label_matched_indices) do
    table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
  end
  -- Do something else
  return highlights
end

local function all_bufnrs()
  return vim.tbl_filter(function(bufnr)
    return vim.bo[bufnr].buftype == ''
  end, vim.api.nvim_list_bufs())
end

local function select_cmp_sources(_)
  local default = { 'lsp', 'snippets', 'path', 'buffer' }
  local success, node = pcall(vim.treesitter.get_node)
  if not success or not node then
    return default
  end
  if vim.tbl_contains(comment_types, node:type()) then
    return { 'buffer' }
  else
    return default
  end
end

local function back_to_normal()
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
end

-- weird behavior due to some screen movement schenanigans?
local function cancel_and_exit(cmp)
  return cmp.cancel({ callback = back_to_normal })
end

local function accept_and_exit(cmp)
  return cmp.accept({ callback = back_to_normal })
end

local function cmd_sources()
  local type = vim.fn.getcmdtype()
  -- Search forward and backward
  if type == '/' or type == '?' then return { 'buffer' } end
  -- Commands
  if type == ':' or type == '@' then
    return { 'cmdline' }
  end
  return {}
end

return {
  -- color rendering of completion labels
  "xzbdmw/colorful-menu.nvim",
  -- completion sources
  -- completion engine
  {
    "saghen/blink.cmp",
    event = events,
    dependencies = {
      "rafamadriz/friendly-snippets",
      "mgalliou/blink-cmp-tmux",
    },
    config = true,
    opts = {
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
                text = kind_icon_text,
              },
              kind = {
                text = kind_text,
                highlight = kind_highlight,
              },
              label = {
                width = { fill = true, max = 60 },
                text = label_text,
                highlight = label_highlight,
              },
            },
          },
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          }
        },
      },
      sources = {
        default = select_cmp_sources,
        providers = {
          buffer = {
            opts = {
              -- or (recommended) filter to only "normal" buffers
              get_bufnrs = all_bufnrs,
            }
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
              trigger_chars = { "." }
            },
          },
        }
      },
      keymap = {
        ['<esc>'] = {
          cancel_and_exit,
          'fallback',
        },
        ['<c-c>'] = {
          'cancel',
        },
        ['<Tab>'] = {
          'select_next',
          'snippet_forward',
          'fallback'
        },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
        -- accept but also exit from input mode.
        ['<s-CR>'] = { accept_and_exit, 'fallback' },
      },
      cmdline = {
        sources = cmd_sources,
        completion = {
          list = {
            selection = {
              preselect = false,
              -- When `true`, inserts the completion item automatically when selecting it
              auto_insert = true,
            },
          },
          menu = { auto_show = true },
        }
      },
    }
  },
  {
    "saghen/blink.compat",
    event = events,
    opts = {}
  },
}
