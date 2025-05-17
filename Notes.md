# Notes

Here I record some of the tips when it comes to solving random issues with
neovim.

### Treesitter Incremental Selection Crash

**Symptom**: After selecting text, attempting to invoke TS incremental selection
causes nvim to crash.

See [issue](https://github.com/nvim-treesitter/nvim-treesitter/issues/5501);
*possibly* fixed by uninstalling all TS parsers then reinstalling.

### Markdown rendering not working properly

**Symptom**: Conceals not working.

Fixed by `:TSInstall markdown_inline`.
