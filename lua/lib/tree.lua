local M = {}

local ts = require 'nvim-treesitter.ts_utils'
local parsers = require "nvim-treesitter.parsers"
local locals = require "nvim-treesitter.locals"
local queries = require "nvim-treesitter.query"

local function get_parent_node(node)
  return node:parent() or node
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
  local node = ts.get_node_at_cursor()
  local par = get_parent_node(node)
  if not par or par == node then
    par = get_parent_scope(node)
  end
  if par then
    ts.goto_node(par, false, true)
  end
end

function M.below_ts_node_by_cursor()
  local node = ts.get_node_at_cursor()
  node = get_first_child(node)
  if node then
    ts.goto_node(node, false, true)
  end
end


function M.next_ts_node_by_cursor()
  local cur = ts.get_node_at_cursor()
  local node = ts.get_next_node(cur, false, true)
  if node then
    ts.goto_node(node, false, true)
  end
end

function M.prev_ts_node_by_cursor()
  local cur = ts.get_node_at_cursor()
  local node = ts.get_previous_node(cur, false, true)
  if node then
    ts.goto_node(node, false, true)
  end
end

function M.swap_with_next_ts_node_by_cursor()
  local cur = ts.get_node_at_cursor()
  -- prefer more conservative movement when swapping
  local node = ts.get_next_node(cur, false, false)
  if node then
    ts.swap_nodes(cur, node, 0, true)
  end
end

function M.swap_with_prev_ts_node_by_cursor()
  local cur = ts.get_node_at_cursor()
  -- prefer more conservative movement when swapping
  local node = ts.get_previous_node(cur, false, false)
  if node then
    ts.swap_nodes(cur, node, 0, true)
  end
end

return M
