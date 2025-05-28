-- Completion related content. While it does not actually depend on the package
-- `blink-cmp`, the API assumed is strictly associated with blink-cmp.

local M = {}

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

function M.kind_icon_text(ctx)
  return " " .. ctx.kind_icon .. " "
end

function M.kind_text(ctx)
  return (kind_map[ctx.kind] or ctx.kind) .. " "
end

function M.kind_highlight(ctx)
  return { { group = ctx.kind_hl, priority = 20000 } }
end

function M.label_text(ctx)
  local highlights_info = require("colorful-menu").blink_highlights(ctx)
  if highlights_info ~= nil then
    -- Or you want to add more item to label
    return highlights_info.label
  else
    return ctx.label
  end
end

function M.label_highlight(ctx)
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

function M.all_bufnrs()
  return vim.tbl_filter(function(bufnr)
    return vim.bo[bufnr].buftype == ''
  end, vim.api.nvim_list_bufs())
end

function M.select_cmp_sources(_)
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

function M.back_to_normal()
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
end

-- weird behavior due to some screen movement schenanigans?
function M.cancel_and_exit(cmp)
  return cmp.cancel({ callback = M.back_to_normal })
end

function M.accept_and_exit(cmp)
  return cmp.accept({ callback = M.back_to_normal })
end

function M.cmd_sources()
  local type = vim.fn.getcmdtype()
  -- Search forward and backward
  if type == '/' or type == '?' then return { 'buffer' } end
  -- Commands
  if type == ':' or type == '@' then
    return { 'cmdline' }
  end
  return {}
end

return M
