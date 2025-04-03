-- LSP configurations

---@diagnostic disable: missing-fields

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
local navic = require("nvim-navic")

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
    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
    vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  end,
})

-- avoids having to individually configure lsps with default capabilities.
local default_setup = function(server)
  require("lspconfig")[server].setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
    end,
  })
end

-- mason
require("mason-lspconfig").setup({
  ensure_installed = {
    -- "ast_grep",
    -- "bashls",
    -- "lua_ls",
    -- "pylsp",
    -- "pyright",
    -- "rust_analyzer",
    -- "marksman",
  },
  handlers = {
    default_setup,
  },
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

lspconfig.pylsp.setup({
  settings = {
    pylsp = {
      plugins = {
        flake8 = {
          maxLineLength = 80,
        },
      },
    },
  },
})

lspconfig.rust_analyzer.setup({
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
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
