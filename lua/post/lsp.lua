-- LSP configurations
local fzf = require("fzf-lua")

local core_lsps = {
  "clangd",
}

vim.lsp.enable(core_lsps)

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

-- symbols
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
