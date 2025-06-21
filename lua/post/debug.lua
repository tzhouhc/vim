local misc = require("lib.misc")

_G.dump = function(o)
  vim.notify("\n" .. misc.dump(o), vim.log.levels.DEBUG)
end
