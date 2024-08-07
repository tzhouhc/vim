-- `local_post` is intended for configuration toggles that are
-- machine-dependent, but possibly changed overtime based on preference instead
-- of functionality. As such it seems inappropriate to add to VCS, but
-- nonetheless should be recorded somehow.
--
-- Of the files in `local_post`, `local.lua` is a copy of `default.lua`, and is
-- actually sourced. `default.lua` is in VCS and serves as a reference sheet.
-- If `local.lua` fails to load, `default.lua` is loaded instead.

local ok, res = pcall(require, "local_post.local")
if not ok then
  print("Error loading local module:\n" .. res)
  require("local_post.default")
end
