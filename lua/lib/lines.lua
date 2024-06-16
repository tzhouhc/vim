-- Contains custom lua/tab line components

local navic = require("nvim-navic")
local notify = require("lib.notify")
local misc = require("lib.misc")

local M = {}

local function layered_symbol_rep()
  local data = navic.get_data()
end

function M.navic_status()
  local res = ""
  if not navic.is_available() then
    return res
  end
  local loc = navic.get_location()
  if loc == "" then
    return res
  end
  return " ➜ " .. loc
end

return M
