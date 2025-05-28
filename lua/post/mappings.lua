-- Keyboard Mapping Configurations, with Plugins
local binder = require("lib.misc")

---- Generic File Mappings ----

-- For automating setting key maps.
-- Usage: highest level keys are modes;
--        individual lines are ["<key>"] = "command" || lua.function
local key_configs = {
  -- Normal mode
  n = {
    ["<leader>q"] = ":BD<cr>",
    ["<leader>lg"] = ":Git<cr>",
    ["<leader>nm"] = ":Namu symbols<cr>",

    -- buffer movement
    -- WARN: not working?
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

binder.batch_set_auto_buf_keymap(key_configs, "general")

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
      binder.batch_set_buf_keymap(help_binds)
    end
  end
})
