-- LSP configurations
--
-- Note: half of these can probably be done in `conf`, but for the sake of
-- centralization with the other half we do it here in `post`.

local has_fzf, fzf = pcall(require, "fzf-lua")
local lsp_key_config = {}

if has_fzf and vim.g.use_fzf_for_lsp then
  lsp_key_config = {
    n = {
      ["gd"] = fzf.lsp_declarations,
      ["gf"] = fzf.lsp_definitions,
      ["gi"] = fzf.lsp_implementations,
      ["gt"] = fzf.lsp_typedefs,
      ["gr"] = fzf.lsp_references,
    }
  }
else
  lsp_key_config = {
    n = {
      ["gd"] = vim.lsp.buf.declaration,
      ["gf"] = vim.lsp.buf.definition,
      ["gi"] = vim.lsp.buf.implementation,
      ["gt"] = vim.lsp.buf.type_definition,
      ["gr"] = vim.lsp.buf.references,
    }
  }
end


local core_lsps = {
  "lua_ls",
  "clangd",
  "basedpyright",
  "prettierd",
  "zls",
  -- "ty",  -- rust-based python lsp, however the feature set is a bit thin rn
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
    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
    vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)

    require("lib.binder").batch_set_auto_buf_keymap(lsp_key_config, "lsp")
  end,
})

-- symbols
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

-- autohover
if vim.g.do_hover then
  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
      vim.lsp.buf.hover()
    end,
    group = vim.api.nvim_create_augroup("LspHover", { clear = true }),
  })
end
