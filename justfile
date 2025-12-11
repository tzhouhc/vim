# Initialize some of the commonly needed tooling for neovim.
# Alternatively, `dotfiles/install` also contains py_requirements for
# the same packages.
init:
  python3 -m pip install pynvim neovim-remote hererocks --break-system-packages
  nvim --headless "+Lazy! sync" +qa
  nvim --headless "+TSUpdate" +qa
  nvim --headless "+MasonInstall tree-sitter-cli" +qa

# Export all available user commands. Note that this *is* affected by the
# config flag to cleanup unwanted commands.
# Generates a `cmds.txt` file in the vim dir.
export-all-cmds:
  nvim --headless +ExportAllCmds +q

reset-prefs:
  mv {{justfile_directory()}}/lua/conf/local.lua {{justfile_directory()}}/lua/conf/local.lua.bk
