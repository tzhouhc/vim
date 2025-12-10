local M = {}

local ts = require("nvim-treesitter.ts_utils")
local parsers = require("nvim-treesitter.parsers")
local locals = require("nvim-treesitter.locals")
local queries = require("nvim-treesitter.query")

local node_list = {}
local current_index = nil

local function start_select()
  node_list = {}
  current_index = nil
  current_index = 1
  vim.cmd("normal! v")
end

local function find_expand_node(node)
  local start_row, start_col, end_row, end_col = node:range()
  local parent = node:parent()
  if parent == nil then
    return nil
  end
  local parent_start_row, parent_start_col, parent_end_row, parent_end_col = parent:range()
  if
    start_row == parent_start_row
    and start_col == parent_start_col
    and end_row == parent_end_row
    and end_col == parent_end_col
  then
    return find_expand_node(parent)
  end
  return parent
end

local function select_parent_node()
  if current_index == nil then
    return
  end

  local node = node_list[current_index - 1]
  local parent = nil
  if node == nil then
    parent = ts.get_node_at_cursor()
  else
    parent = find_expand_node(node)
  end
  if not parent then
    vim.cmd("normal! gv")
    return
  end

  table.insert(node_list, parent)
  current_index = current_index + 1
  local start_row, start_col, end_row, end_col = parent:range()
  vim.fn.setpos(".", { 0, start_row + 1, start_col + 1, 0 })
  vim.cmd("normal! v")
  vim.fn.setpos(".", { 0, end_row + 1, end_col, 0 })
end

local function restore_last_selection()
  if not current_index or current_index <= 1 then
    return
  end

  current_index = current_index - 1
  local node = node_list[current_index]
  local start_row, start_col, end_row, end_col = node:range()
  vim.fn.setpos(".", { 0, start_row + 1, start_col + 1, 0 })
  vim.cmd("normal! v")
  vim.fn.setpos(".", { 0, end_row + 1, end_col, 0 })
end

if vim.g.use_safe_incremental_selection then
  vim.keymap.set("n", "v", start_select, { noremap = true, silent = true })
  vim.keymap.set("v", "<TAB>", select_parent_node, { noremap = true, silent = true })
  vim.keymap.set("v", "<BS>", restore_last_selection, { noremap = true, silent = true })
end

local function print_node(node, depth)
  if depth <= 0 then
    return
  end
  print("Node(" .. node:type() .. ")")
  for c in node:iter_children() do
    print_node(c, depth - 1)
  end
end

function M.print_cur_node()
  local node = ts.get_node_at_cursor()
  print_node(node, 2)
end

-- return the highest node in the tree that shares the same start coord as node.
local function get_static_parent_node(node)
  if not node then
    return nil
  end

  local start_row, start_col = node:start()
  local current = node
  local parent = current:parent()

  while parent do
    local parent_row, parent_col = parent:start()
    -- If parent has a different start position (row or column),
    -- we've found a meaningful parent
    if parent_row ~= start_row or parent_col ~= start_col then
      break
    end
    -- Move up to the next parent
    current = parent
    parent = current:parent()
  end
  return current
end

local function get_static_node_at_cursor()
  local node = ts.get_node_at_cursor()
  return get_static_parent_node(node) or node
end

-- return the parent TSNode of the current cursor node; might not exist,
-- or it might be an empty node above current node, in latter case keep moving
-- up until getting to a node that has a different coord.
local function get_parent_node(node)
  local par = get_static_parent_node(node)
  if not par then
    return node
  else
    return par:parent() or par
  end
end

local function get_parent_scope(node)
  local lang = parsers.get_buf_lang()
  if queries.has_locals(lang) then
    return locals.containing_scope(node:parent() or node)
  else
    return node
  end
end

local function get_first_child(node)
  return node:child(0) or node
end

function M.above_ts_node_by_cursor()
  local node = get_static_node_at_cursor()
  local par = get_parent_node(node)
  if not par or par == node then
    par = get_parent_scope(node)
  end
  if par then
    ts.goto_node(par, false, true)
  end
end

function M.below_ts_node_by_cursor()
  local node = get_static_node_at_cursor()
  if not node then
    return
  end
  node = get_first_child(node)
  if node then
    ts.goto_node(node, false, true)
  end
end

function M.next_ts_node_by_cursor()
  local cur = get_static_node_at_cursor()
  if not cur then
    return
  end
  local node = cur and ts.get_next_node(cur, false, true)

  while node and node:extra() do
    node = ts.get_next_node(node, false, true)
  end

  if node then
    ts.goto_node(node, false, true)
  end
end

function M.prev_ts_node_by_cursor()
  local cur = get_static_node_at_cursor()
  if not cur then
    return
  end
  local node = cur and ts.get_previous_node(cur, false, true)

  while node and node:extra() do
    node = ts.get_previous_node(node, false, true)
  end

  if node then
    ts.goto_node(node, false, true)
  end
end

function M.swap_with_next_ts_node_by_cursor()
  local cur = get_static_node_at_cursor()
  if not cur then
    return
  end
  -- prefer more conservative movement when swapping
  local node = ts.get_next_node(cur, false, false)
  if node then
    ts.swap_nodes(cur, node, 0, true)
  end
end

function M.swap_with_prev_ts_node_by_cursor()
  local cur = get_static_node_at_cursor()
  if not cur then
    return
  end
  -- prefer more conservative movement when swapping
  local node = ts.get_previous_node(cur, false, false)
  if node then
    ts.swap_nodes(cur, node, 0, true)
  end
end

return M
