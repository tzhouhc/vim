local events = { "BufReadPost", "BufNewFile", "BufWritePre" }

-- TODO: disable completion in comments

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
}

return {
  "xzbdmw/colorful-menu.nvim",
  -- completions
  {
    "saghen/blink.cmp",
    event = events,
    config = true,
    opts = {
      signature = { enabled = true },
      completion = {
        -- Show documentation when selecting a completion item
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        -- Display a preview of the selected item on the current line
        ghost_text = { enabled = true },

        -- rendering of the actual completion menu
        menu = {
          draw = {
            columns = { { "kind_icon", "kind" }, { "label", gap = 1 } },
            components = {
              kind_icon = {
                text = function(ctx)
                  return " " .. ctx.kind_icon .. " "
                end,
              },
              kind = {
                text = function(ctx)
                  return (kind_map[ctx.kind] or ctx.kind) .. " "
                end,
                highlight = function(ctx)
                  return { { group = ctx.kind_hl, priority = 20000 } }
                end
              },
              label = {
                width = { fill = true, max = 60 },
                text = function(ctx)
                  local highlights_info = require("colorful-menu").blink_highlights(ctx)
                  if highlights_info ~= nil then
                    -- Or you want to add more item to label
                    return highlights_info.label
                  else
                    return ctx.label
                  end
                end,
                highlight = function(ctx)
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
                end,
              },
            },
          },
        },
        list = {
          selection = {
            preselect = false,
          }
        },
        sources = {
          default = function(_)
            local default = { 'lsp', 'path', 'snippets', 'buffer' }
            local success, node = pcall(vim.treesitter.get_node)
            if not success or not node then
              return default
            end
            if vim.tbl_contains(comment_types, node:type()) then
              return { 'buffer' }
            else
              return default
            end
          end,
          providers = {
            buffer = {
              opts = {
                -- or (recommended) filter to only "normal" buffers
                get_bufnrs = function()
                  return vim.tbl_filter(function(bufnr)
                    return vim.bo[bufnr].buftype == ''
                  end, vim.api.nvim_list_bufs())
                end
              }
            }
          }
        }
      },
      keymap = {
        ['<Tab>'] = {
          'select_next',
          'snippet_forward',
          'fallback'
        },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
      },
    }
  },
  {
    "saghen/blink.compat",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    event = events,
    opts = {
      sources = {
        -- remember to enable your providers here
        default = { 'lsp', 'path', 'snippets', 'buffer' }
      },
    }
  },
}
