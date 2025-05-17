return {
  -- languages
  { "preservim/vim-markdown", ft = { "markdown" } },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
      file_types = { "Avante", "markdown" },
      heading = {
        width = "block",
        min_width = 1,
        right_pad = 1,
        icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰲦 ", "󰲨 ", "󰲪 " },
      },
      code = {
        width = 'block',
        left_pad = 0,
        right_pad = 2,
        language_pad = 2,
        min_width = 40,
        border = 'thin',
      },
      sign = {
        enabled = true,
      },
      checkbox = {
        enabled = true,
        position = 'inline',
        unchecked = {
          icon = '󰄱',
          highlight = 'RenderMarkdownUnchecked',
        },
        checked = {
          icon = '󰱒',
          highlight = 'RenderMarkdownChecked',
        },
        custom = {
          todo = { raw = '[-]', rendered = '󰥔', highlight = 'RenderMarkdownTodo' },
          unsure = { raw = '[?]', rendered = '', highlight = 'RenderMarkdownTodo' },
        },
      },
      pipe_table = { preset = 'heavy' },
    },
    ft = { "Avante", "markdown" },
  },
}
