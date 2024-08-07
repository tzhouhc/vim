return {
  -- custom sign column
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        -- configuration goes here, for example:
        segments = {
          {
            sign = { namespace = { "diagnostic/signs" }, maxwidth = 1, auto = true },
            click = "v:lua.ScSa"
          },
          {
            text = { builtin.lnumfunc },
            click = "v:lua.ScLa",
          },
          { sign = { namespace = { "gitsigns" }, maxwidth = 1, auto = false } },
          {
            text = { builtin.foldfunc },
            click = "v:lua.ScFa",
          },
        }
      })
    end
  },
}
