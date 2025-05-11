-- `local` is intended for configuration toggles that are high-level,
-- machine-dependent, but possibly changed overtime based on preference instead
-- of functionality. As such it seems inappropriate to add to VCS, but
-- nonetheless should be recorded somehow.
--
-- Of the files in `local`, `local.lua` is a copy of `default.lua`, and is
-- actually sourced. `default.lua` is in VCS and serves as a reference sheet.
-- If `local.lua` fails to load, `default.lua` is loaded instead.

require("local.default")
pcall(require, "local.local")
