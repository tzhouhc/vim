-- Color utilities -- blending color, converting from hex strings, getting
-- color from highlight groups, etc.

local M = {}

local function strip_hash(s)
  if s:find("^#") ~= nil then
    return s:sub(2)
  end
  return s
end

local function hex_to_table(h)
  local r = tonumber(h:sub(1, 2), 16)
  local g = tonumber(h:sub(3, 4), 16)
  local b = tonumber(h:sub(5), 16)
  -- print("r: "..r.." g: "..g.." b: "..b)
  return { r, g, b }
end

-- mix a _single_ color among r, g, and b.
local function mix_color(a, b, pa)
  -- a linear combination of a and b with weight pa for a.
  local num = math.floor(a * pa) + math.floor(b * (1 - pa))
  -- keep between 2 hex digits.
  local adjusted = math.min(math.max(num, 0), 255)
  -- convert to hex string
  local res = string.format("%x", adjusted)
  return res
end

--- Mixes two RGB color strings with an optional ratio.
---@param a string The first color.
---@param b string The second color.
---@param pa number The mixture ratio for a, should be a number between 0 and 1. The mixture
---of b is automatically (1 - a).
---@return string
function M.mix_colors(a, b, pa)
  local color_a = hex_to_table(strip_hash(a))
  local color_b = hex_to_table(strip_hash(b))
  pa = pa or 0.5 -- default to even mix
  local res = "#"
  for i, _ in ipairs(color_a) do
    res = res .. mix_color(color_a[i], color_b[i], pa)
  end
  return res
end

local function get_hg_field(group_name, field)
  local hl_info = vim.api.nvim_get_hl(0, { name = group_name })
  if hl_info and hl_info[field] then
    return string.format("#%06x", hl_info[field])
  else
    return nil
  end
end

--- Find the background color of Neovim itself
function M.global_bg()
  return get_hg_field("Normal", "bg")
end

function M.fg_by_hlgroup(group_name)
  return get_hg_field(group_name, "fg")
end

function M.bg_by_hlgroup(group_name)
  return get_hg_field(group_name, "bg")
end

return M
