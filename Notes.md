# Notes

Here I record some of the tips when it comes to solving random issues with
neovim.

### Conform/LSP Installation

Both Conform linter/formatters and LSPs can be installed via Mason -- Mason
just makes these binaries available to nvim. Check with `ConformInfo` and then
install with `MasonInstall`. Tools should become immediately available.

### Treesitter Incremental Selection Crash

**Symptom**: After selecting text, attempting to invoke TS incremental selection
causes nvim to crash.

See [issue](https://github.com/nvim-treesitter/nvim-treesitter/issues/5501);
_possibly_ fixed by uninstalling all TS parsers then reinstalling.

### Markdown rendering not working properly

**Symptom**: Conceals not working.

Fixed by `:TSInstall markdown_inline`.

### Strikethrough

**Symptom**: strikethrough doesn't render correctly while using terminals that
support it.

Fixed by:

```
infocmp $TERM > myterm.info
vim myterm.info # add `smxx=\E[9m, rmxx=\E[29m,`
tic -x myterm.info
```

[Source](https://github.com/neovim/neovim/discussions/24346#discussioncomment-9197378)

### Failure to Install `pylsp`

Run `sudo apt install python3-venv`

### Crossed-out Headers in Markdowns

Fix: disable `vim.g.crossout_diff_delete`. Apparently some colorschemes just
use `DiffDelete` as a shortcut for "Red".

### Cursor Flickering

**Symptom**: Cursor flickers around when moving fast, especially if `noice`
is on. Apparently only happens in `zellij` but not `tmux`.

Fix: turn off `termsync` or (preferrably) use latest `zellij` (>0.40).

### Ctrl-Number Keymap

**Symptom**: these would not work as natively they don't send valid keycodes.
To get it working would require some sort of synchronized effort between the
terminal emulator and neovim.

### Neovim Slow Startup Time

**Symptom**: Without changing configs, Neovim hitting over 200ms startup time.

*Potential Fix*: if on macos, verify that Neovim binary is of the correct
architecture. `x86_64` binary *will* still run on ARM-chipped macs but with
considerable performance loss. Just using the precompiled releases from github
should be fine.
