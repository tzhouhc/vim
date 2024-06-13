if vim.version().minor < 10 then
  return {
    {
      "numToStr/Comment.nvim",
      config = true,
    },
  }
else
  return {}
end
