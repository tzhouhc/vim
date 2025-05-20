# Notes

Here I record some of the tips when it comes to solving random issues with
neovim.

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
