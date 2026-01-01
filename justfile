# Initialize some of the commonly needed tooling for neovim.
# Alternatively, `dotfiles/install` also contains py_requirements for
# the same packages.
init:
  nvim --headless "+Lazy! sync" +qa
  nvim --headless "+TSUpdate" +qa
  nvim --headless "+MasonInstall tree-sitter-cli" +qa

# initialize python dependency
init-py:
  python3 -m pip install pynvim neovim-remote hererocks --break-system-packages

# initialize python dependency using uv
init-uv:
  uv tool install --upgrade pynvim --with neovim
  uv tool install --upgrade hererocks
  uv tool install --upgrade neovim-remote

# Export all available user commands. Note that this *is* affected by the
# config flag to cleanup unwanted commands.
# Generates a `cmds.txt` file in the vim dir.
export-all-cmds:
  nvim --headless +ExportAllCmds +q

reset-prefs:
  mv {{justfile_directory()}}/lua/conf/local.lua {{justfile_directory()}}/lua/conf/local.lua.bk
