return {
  -- languages
  { "preservim/vim-markdown" },
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
        left_pad = 2,
        right_pad = 2,
        language_pad = 2,
        min_width = 40,
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
  -- for advanced usage
  { "LhKipp/nvim-nu",        ft = "nu", opts = { use_lsp_features = false } },
	{ "mmarchini/bpftrace.vim" },
}
