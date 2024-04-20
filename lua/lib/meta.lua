local M = {}

-- toggle on whether to display load time stack trace if load failed.
M.debug = true

-- returned in place of normal plugins so that errors are silenced.
local NullSetup = {}
-- for the typical plugin's invocation of `setup(opts)`
function NullSetup.setup(...)
end
-- for telescope extensions
function NullSetup.load_extension(...)
end
-- for luasnip extensions
function NullSetup.lazy_load(...)
end

-- protected call for loading plugins but not failing the entire script if
-- any individual thing should fail.
-- returns the module normally, or a NullSetup in case of failure. The NullSetup
-- object will run `setup` and `load_extension` functions with any params.
function M.safe_require(name)
  local ok, res = pcall(require, name)
  if ok then
    return res
  else
    -- won't be silenced: this will invoke a hit-enter event
    if M.debug then
      print("Error loading module: "..name.."\n"..res)
    else
      print("Error loading module: "..name)
    end
  end
  return NullSetup
end

return M
