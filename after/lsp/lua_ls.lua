-- lua
return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "hs" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          -- hammerspoon
          ["/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/"] = true,
        },
      },
    },
  },
}
