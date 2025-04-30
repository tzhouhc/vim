return {
  {
    "FabijanZulj/blame.nvim",
    cmd = { "BlameToggle" },
    config = function()
      -- custom fixed format function
      local utils = require("blame.utils")
      local function format(line_porcelain, config, idx)
        local hash = string.sub(line_porcelain.hash, 0, 7)
        local line_with_hl = {}
        local is_commited = hash ~= "0000000"
        if is_commited then
          line_with_hl = {
            idx = idx,
            values = {
              {
                textValue = hash,
                hl = "Comment",
              },
              {
                textValue = utils.format_time(
                  config.date_format,
                  line_porcelain.committer_time
                ),
                hl = hash,
              },
              {
                textValue = line_porcelain.author,
                hl = hash,
              },
            },
            format = "%s  %s  %s",
          }
        else
          line_with_hl = {
            idx = idx,
            values = {
              {
                textValue = "Not Committed",
                hl = "Comment",
              },
            },
            format = "%s",
          }
        end
        return line_with_hl
      end

      require("blame").setup({
        blame_options = { '-w', '-CCC' },
        colors = {
          "#61AFEF",
          "#C678DD",
          "#E06C75",
          "#98C379",
          "#E5C07B",
          "#56B6C2",
          "#D19A66",
          "#FF79C6",
          "#8BE9FD",
          "#50FA7B",
          "#FFD700",
          "#FF92D0",
          "#9EFFFF",
          "#FFAF00",
          "#87CEFA",
        },
        merge_consecutive = true,
        focus_blame = false,
        commit_detail_view = "tab",
        views = { default = require("blame.views.virtual_view") },
        format_fn = format,
      })
    end,
    virtual_style = "right_align",
  },
}
