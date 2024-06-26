-- Command Palette Customizations

-- Custom Commands
local scopes = require("lib.scopes")
local misc = require("lib.misc")
local terms = require("lib.terms")
local popups = require("lib.popups")

-- Finding common files
vim.api.nvim_create_user_command("Runtimes", scopes.runtime_files, {})
vim.api.nvim_create_user_command("VimConfigs", scopes.find_configs, {})
vim.api.nvim_create_user_command("Dotfiles", scopes.find_dotfiles, {})
vim.api.nvim_create_user_command("Snippets", scopes.find_snippets, {})
vim.api.nvim_create_user_command("GrepAcrossRepo", scopes.live_grep_across_repo, {})

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
vim.api.nvim_create_user_command("H", popups.help_popup, { nargs = "?", complete = "help" })

-- Commander
local c = require("commander")

local function make_simple(name, com)
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
  { "Aerial",                           com = "<CMD>AerialToggle!<cr>",               cat = "Analysis" },
  { "DevDocs",                          com = "<CMD>DevdocsOpenCurrentFloat<cr>",     cat = "Documentation" },
  { "UndoTree",                         com = "<CMD>UndotreeToggle<cr>",              cat = "Tools" },
  { "Unfold All",                       com = "zR",                                   cat = "Folding" },
  { "Fold All",                         com = "zM",                                   cat = "Folding" },
  { "Changed Files in Repo",            com = "<CMD>Easypick changed_files<cr>",      cat = "Tools" },
  { "Grep Across Repository",           com = "<CMD>GrepAcrossRepo<cr>",              cat = "Tools" },
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
    c.add({ make_simple(name, command) }, { cat = cat })
  else
    c.add({ make_simple(com, ":" .. com .. "<cr>") }, { cat = "Tools" })
  end
end
