-- Keyboard Mapping Configurations, with Plugins
local key_utils = require("lib.key_utils")
local df = require("lib.diffs")
local terms = require("lib.terms")
local popups = require("lib.popups")
local fts = require("lib.ft")

---- Generic File Mappings ----

-- to avoid creating mappings in unusual buffers, we exclude them explicitly.
local normal_buffer_mappings = vim.api.nvim_create_augroup("NormalBufferMappings", { clear = true })

-- For automating setting key maps.
-- Usage: highest level keys are modes;
--        individual lines are ["<key>"] = "command" || lua.function
local key_configs = {
  -- Normal mode
  n = {
    ["<leader>q"] = ":BD<cr>",
    ["<leader>ql"] = key_utils.toggle_quickfix,
    ["<leader>lg"] = ":Git<cr>",
    ["<leader>nm"] = ":Namu symbols<cr>",
    ["<leader>pp"] = popups.toggle_info_popup,

    -- diffview
    ["<leader>dv"] = key_utils.toggle_diffview,

    -- quake term
    ["<m-e>"] = terms.quake_term,

    -- diagnostics movement
    ["[e"] = function() vim.diagnostic.jump({ count = -1 }) end,
    ["]e"] = function() vim.diagnostic.jump({ count = 1 }) end,
    -- create empty lines without moving
    ["[<space>"] = key_utils.add_blank_line_before,
    ["]<space>"] = key_utils.add_blank_line_after,
    -- move between change hunks
    ["[c"] = df.prev_hunk,
    ["]c"] = df.next_hunk,

    -- buffer movement
    ["<c-1>"] = "<Cmd>BufferLineGoToBuffer 1<CR>",
    ["<c-2>"] = "<Cmd>BufferLineGoToBuffer 2<CR>",
    ["<c-3>"] = "<Cmd>BufferLineGoToBuffer 3<CR>",
    ["<c-4>"] = "<Cmd>BufferLineGoToBuffer 4<CR>",
    ["<c-5>"] = "<Cmd>BufferLineGoToBuffer 5<CR>",
    ["<c-6>"] = "<Cmd>BufferLineGoToBuffer 6<CR>",
    ["<c-7>"] = "<Cmd>BufferLineGoToBuffer 7<CR>",
    ["<c-8>"] = "<Cmd>BufferLineGoToBuffer 8<CR>",
    ["<c-9>"] = "<Cmd>BufferLineGoToBuffer 9<CR>",
    ["<c-0>"] = "<Cmd>BufferLineGoToBuffer -1<CR>",

    -- formatting
    ["<leader>fc"] = "<Cmd>FormatCode<cr>",

    -- local fuzzy find
    ["<m-f>"] = terms.repo_live_grep,

    -- smarter shift I
    ["I"] = key_utils.smarter_shift_i,
  },
  -- Visual mode
  v = {
    -- formatting
    ["<leader>fc"] = "<Cmd>FormatCode<cr>",

    -- surround
    ["q"] = {"<Plug>(nvim-surround-visual)'", {}},
    ["Q"] = {"<Plug>(nvim-surround-visual)\"", {}},
    ["'"] = {"<Plug>(nvim-surround-visual)'", {}},
    ["\""] = {"<Plug>(nvim-surround-visual)\"", {}},
    ["("] = {"<Plug>(nvim-surround-visual))", {}},
    [")"] = {"<Plug>(nvim-surround-visual))", {}},
    ["["] = {"<Plug>(nvim-surround-visual)]", {}},
    ["]"] = {"<Plug>(nvim-surround-visual)]", {}},
  },
  [{ "n", "v" }] = {
    -- jump to first position after the first space (to avoid comment prefixes).
    ["0"] = key_utils.alternating_zero,
  },
  [{ "i", "s" }] = {
    -- fallback value of these commands are hardcoded to tab and s-tab, so
    -- change the corresponding func if changed here.
    ["<c-right>"] = { key_utils.vsnip_jump_forward, { expr = true } },
    ["<c-left>"] = { key_utils.vsnip_jump_backward, { expr = true } },
  },
  -- Terminal mode
  t = {
  },
  -- Command mode, abbrev
  ca = {
    ["h"] = "H",
  },
  -- selection by textobject
  [{ "o", "x" }] = {
    ["ih"] = ":<C-U>Gitsigns select_hunk<CR>",
  }
}

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  group = normal_buffer_mappings,
  callback = function(args)
    local bufnr = args.buf
    if not fts.is_normal_buffer(bufnr) then
      return
    end
    require("lib.misc").batch_set_buf_keymap(key_configs)
  end,
})

---- Mappings specific to Help ----
-- use help tags as if they are LSP symbols and jump using `g;`
local help_binds_grp = vim.api.nvim_create_augroup("HelpMappings", { clear = true })
local help_binds = {
  n = {
    ["gd"] = "<c-]>",
    ["g;"] = "<c-o>",
  }
}

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  group = help_binds_grp,
  callback = function(args)
    local bufnr = args.buf
    local filetype = vim.bo[bufnr].filetype
    if filetype == "help" then
      require("lib.misc").batch_set_buf_keymap(help_binds)
    end
  end
})
