-- LSP configurations

---@diagnostic disable: missing-fields

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
local navic = require("nvim-navic")
local fzf = require("fzf-lua")

vim.g.vsnip_snippet_dir = "$VIM_HOME/snippets"

-- LSP dedicated key mappings
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.lsp.inlay_hint.enable(true)

    -- these will be buffer-local keybindings
    -- because they only work if you have an active language server
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    vim.keymap.set("n", "gd", fzf.lsp_declarations, opts)
    vim.keymap.set("n", "gf", fzf.lsp_definitions, opts)
    vim.keymap.set("n", "gi", fzf.lsp_implementations, opts)
    vim.keymap.set("n", "gt", fzf.lsp_typedefs, opts)
    vim.keymap.set("n", "gr", fzf.lsp_references, opts)
    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
    vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  end,
})

-- NOTE: this part has issues with nvim-0.10 after it incorporate 0.11
-- compatibility
-- navic.attach(client, bufnr)

local core_lsps = {
  "lua_ls",
  "clangd",
  "basedpyright",
}

-- mason
require("mason-lspconfig").setup({
  -- we might manually install other plugins, but they should not be autorunning
  -- until approved.
  ensure_installed = core_lsps,
  automatic_enable = core_lsps,
})

-- c
-- Note that clangd requires manual installation on some architectures.
lspconfig.clangd.setup({
  cmd = { "clangd", "--background-index", "--clang-tidy" },
})

-- lua
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "hs" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          -- hammerspoon
          ["/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/"] = true,
        },
      },
    },
  },
})

-- rust
lspconfig.rust_analyzer.setup({
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
})

-- harper grammar checker; unused
local harper_conf = {
  settings = {
    ["harper-ls"] = {
      linters = {
        spell_check = true,
        spelled_numbers = false,
        an_a = true,
        sentence_capitalization = false,
        unclosed_quotes = true,
        wrong_quotes = false,
        long_sentences = true,
        repeated_words = true,
        spaces = true,
        matcher = true,
        correct_number_suffix = true,
        number_suffix_capitalization = true,
      },
    },
  },
}

-- symbols
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
