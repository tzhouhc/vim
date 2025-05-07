return {
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        -- I forgot why
        enable = false,
      },
      rustfmt = {
        extraArgs = { "--config", "tab_spaces=2" },
      },
    },
  },
}
