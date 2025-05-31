-- Custom Commands
--
-- Note that we now strive to only keep non-plugin-based commands here -- any
-- commands that depends on a plugin should be defined within the plugin's
-- config function so as to be lazy-loaded alongside. If a command depends on
-- multiple plugins, then inter-plugin dependencies should be declared first,
-- then the command be associated with the "primary" plugin.

local misc = require("lib.misc")

-- Tooling shortcuts
vim.api.nvim_create_user_command("GetPluginLink", misc.get_current_line_plugin, {})
vim.api.nvim_create_user_command("Scratch", misc.make_scratch, {})

-- Cleaning up unwanted commands
local unwanted_cmds = {
  "Vexplore",
  "ColorizerDetachFromBuffer",
  "ColorizerReloadAllBuffers",
  "ColorizerToggle",
  "ConformInfo",
  "DoMatchParen",
  "EditQuery",
  "Explore",
  "Hexplore",
  "IlluminateDebug",
  "IlluminatePause",
  "IlluminatePauseBuf",
  "IlluminateResume",
  "IlluminateResumeBuf",
  "IlluminateToggle",
  "IlluminateToggleBuf",
  "InspectTree",
  "Lexplore",
  "BufferLineGroupToggle",
  "BufferLineGroupClose",
  "BufferLineTabRename",
  "BufferLineTogglePin",
  "BufferLineSortByTabs",
  "BufferLineSortByRelativeDirectory",
  "BufferLineSortByDirectory",
  "BufferLineSortByExtension",
  "BufferLineMovePrev",
  "BufferLineMoveNext",
  "BufferLineCloseOthers",
  "BufferLineCloseLeft",
  "BufferLineCloseRight",
  "BufferLineCyclePrev",
  "BufferLineCycleNext",
  "BufferLinePickClose",
  "BufferLinePick",
  "NetUserPass",
  "NetrwClean",
  "NetrwSettings",
  "Nexplore",
  "NoiceAll",
  "NoiceConfig",
  "NoiceDebug",
  "NoiceDisable",
  "NoiceDismiss",
  "NoiceEnable",
  "NoiceErrors",
  "NoiceLast",
  "NoiceLog",
  "NoicePick",
  "NoiceRoutes",
  "NoiceSnacks",
  "NoiceStats",
  "NoiceViewstats",
  "Nread",
  "Nsource",
  "Ntree",
  "MasonUninstallAll",
  "MasonLog",
  "MasonUninstall",
  "MasonUpdate",
  "ScrollbarHide",
  "Sexplore",
  "TSTextobjectSelect",
  "TodoTelescope",
  "TSTextobjectSwapPrevious",
  "UfoDetach",
  "UfoDisableFold",
  "Callsites",
  "UfoEnableFold",
  "UfoInspect",
  "UpdateRemotePlugins",
  "UfoEnable",
  "UfoDisable",
  "TSEditQueryUserAfter",
  "TSEditQuery",
  "HelpTags",
  "TSEnable",
  "UfoAttach",
  "TSBufEnable",
  "TSTextobjectPeekDefinitionCode",
  "TSUpdateSync",
  "Tutor",
  "TSInstallSync",
  "TodoTrouble",
  "TodoQuickFix",
  "TodoFzfLua",
  "TSInstallFromGrammar",
  "TSInstall",
  "Texplore",
  "TSUninstall",
  "TSToggle",
  "TSTextobjectSwapNext",
  "TSTextobjectRepeatLastMovePrevious",
  "TSTextobjectRepeatLastMoveOpposite",
  "TSTextobjectRepeatLastMoveNext",
  "TSTextobjectRepeatLastMove",
  "TSTextobjectGotoPreviousEnd",
  "TSTextobjectGotoPreviousStart",
  "TSTextobjectGotoNextEnd",
  "TSTextobjectGotoNextStart",
  "TSTextobjectBuiltint",
  "TSTextobjectBuiltinf",
  "TSTextobjectBuiltinT",
  "TSTextobjectBuiltinF",
  "TSModuleInfo",
  "NoMatchParen",
  "TSInstallInfo",
  "TSDisable",
  "TSConfigInfo",
  "TSBufToggle",
  "TSBufDisable",
  "TOhtml",
  "ScrollbarShow",
  "RegexplainerToggle",
  "RegexplainerShow",
  "PrintTSNode",
  "PlenaryBustedFile",
  "PlenaryBustedDirectory",
  "Pexplore",
  "Nwrite",
  "BlinkCmp",
  "NoiceTelescope",
  "NoiceHistory",
  "NoiceFzf",
  "NvimWebDeviconsHiTest",
  "MatchEnable",
  "MatchDisable",
  "MatchDebug",
  "LazyDev",
  "CatppuccinCompile",
  "Catppuccin",
}

local function del_unwanted_cmds()
  for _, cmd in pairs(unwanted_cmds) do
    pcall(vim.api.nvim_del_user_command, cmd)
  end
end

-- call once as part of booting-up
if vim.g.cleanup_usercmds then
  del_unwanted_cmds()

  local grp = vim.api.nvim_create_augroup("UsercmdCleanup", { clear = true })
  -- ensure these gets cleaned up again in case they were being reinserted
  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*.*" },
    callback = del_unwanted_cmds,
    group = grp,
  })
end

local function export_all_cmds()
  local res = ""
  local all_cmds = vim.api.nvim_get_commands({})
  for cmd, _ in pairs(all_cmds) do
    res = res .. cmd .. "\n"
  end
  local output = vim.fs.joinpath(vim.g.vim_home, "cmds.txt")
  local file = io.open(output, "w")
  assert(file)
  io.output(file)
  io.write(res)
  io.close(file)
end

vim.api.nvim_create_user_command("ExportAllCmds", export_all_cmds, {})
