# In a fresh installation of Neovim, the local.lua symlink points to a null
# target. It does not affect usage, but prevents editing local configs.
init:
  #!/usr/bin/env zsh
  if [[ ! -f ./lua/conf/local.lua ]]; then
    cp ./lua/conf/local_defaults.lua ./lua/conf/local.lua
  fi

# Export all available user commands. Note that this *is* affected by the
# config flag to cleanup unwanted commands.
# Generates a `cmds.txt` file in the vim dir.
export-all-cmds:
  nvim --headless +ExportAllCmds +q
