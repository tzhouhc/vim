-- Command Palette Customizations

-- Custom Commands
local scopes = require("lib.scopes")
local misc = require("lib.misc")
local terms = require("lib.terms")

-- Finding common files
vim.api.nvim_create_user_command("Runtimes", scopes.runtime_files, {})
vim.api.nvim_create_user_command("VimConfigs", scopes.find_configs, {})
vim.api.nvim_create_user_command("Dotfiles", scopes.find_dotfiles, {})
vim.api.nvim_create_user_command("Snippets", scopes.find_snippets, {})

-- Telescope shortcuts
vim.api.nvim_create_user_command("Marks", require("telescope.builtin").marks, {})

-- Tooling shortcuts
vim.api.nvim_create_user_command("GetPluginLink", misc.get_current_line_plugin, {})
vim.api.nvim_create_user_command("FormatCode", function()
  vim.lsp.buf.format({ async = true })
end, {})

-- Popup terminals
vim.api.nvim_create_user_command("Git", terms.lazy_git, {})
vim.api.nvim_create_user_command("Yazi", terms.yazi, {})
vim.api.nvim_create_user_command("FloatRight", terms.right_side_term, {})

-- Commander
local c = require("commander")

local function makeSimple(name, com)
  return {
    desc = name,
    cmd = com,
  }
end

local commands_table = {
  "Runtimes",
  "Twilight",
  "Nerdy",
  "Lazy",
  "Git",
  "Trouble",
  "Mason",
  "Yazi",
  "ZenMode",
  "Marks",
  { "DevDocs",                          com = "<CMD>DevdocsOpenCurrentFloat<cr>",     cat = "Documentation" },
  { "UndoTree",                         com = "<CMD>UndotreeToggle<cr>",              cat = "Tools" },
  { "Unfold All",                       com = "zR",                                   cat = "Folding" },
  { "Fold All",                         com = "zM",                                   cat = "Folding" },
  { "Vim Configs",                      com = "<CMD>VimConfigs<cr>",                  cat = "Configs" },
  { "Dot files",                        com = "<CMD>Dotfiles<cr>",                    cat = "Configs" },
  { "Snippet files",                    com = "<CMD>Snippets<cr>",                    cat = "Configs" },
  { "Ctags Config",                     com = "<CMD>e ~/.dotfiles/configs/ctags<cr>", cat = "Configs" },
  { "Symbols Outline",                  com = "<CMD>SymbolsOutline<cr>" },
  { "Format Code",                      com = "<CMD>LspZeroFormat<cr>" },
  { "File Tree",                        com = "<CMD>NvimTreeToggle<cr>" },
  { "Colorizer",                        com = "<CMD>ColorizerToggle<cr>" },
  { "Edit Working Directory as Buffer", com = "<CMD>Oil --float<cr>" },
  { "Telescope",                        com = "<CMD>Telescope<cr>" },
  { "Tags",                             com = "<CMD>Telescope tags<cr>" },
  { "Registers",                        com = "<CMD>Telescope registers<cr>" },
}

for _, com in pairs(commands_table) do
  if type(com) == "table" then
    local name = com[1]
    local cat = com["cat"] or "Tools"
    local command = com["com"] or name
    c.add({ makeSimple(name, command) }, { cat = cat })
  else
    c.add({ makeSimple(com, ":" .. com .. "<cr>") }, { cat = "Tools" })
  end
end
