return {
  {
    "rgroli/other.nvim",
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
