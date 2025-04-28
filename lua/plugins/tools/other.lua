return {
  {
    "rgroli/other.nvim",
    cmd = { "Other" },
    config = function()
      require("other-nvim").setup({
        mappings = {
          {
            pattern = "/src/(.*).c",
            target = "/include/%1.h",
          },
          {
            pattern = "/src/(.*).h",
            target = "/include/%1.c",
          },
        },
      })
    end
  },
}
