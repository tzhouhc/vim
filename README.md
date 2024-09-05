# Ting's NeoVim Setup

## Structure

### init.lua

The `init.lua` config file handles the overall config loading code, and is
fairly simple in and of itself.

### lua

The `lua` directory contains all the detailed customizations for the setup.

#### conf

The `conf` directory contains customizations that are largely unrelated to
plugins -- i.e. settings native to NeoVim, or does not require plugins to load.
(they might still need plugins to function).

#### lib

The `lib` directory contains code usable in other bits of config and is _not_
sourced directly.

#### local

The `local` directory contains code that is used for configuration, but is not
intended to be saved to version control, e.g. recent colorscheme choices. A
`default.lua` is provided as a template. The actual script loaded is
`local.lua`.

#### plugins

The `plugins` directory contains plugin specs for `lazy.nvim`. They are mostly
organized by type, though some plugins have additional customizations and take
up a file by themselves.

#### post

The `post` directory contains setup instructions that must run after sourcing
all the other options above, e.g. certain plugin setups.

### after

The `after` directory contains the `ftplugin` scripts for language specific
configurations.

### local

The `local` directory contains runtime files that can be loaded but are not
saved to version control.

### snippets

The `snippets` directory contians snippets in the "hrsh7th/vim-vsnip" format.


## Features

* Support for local LLM code generation
* Visual elements similar to other modern IDEs (tabs, tagline, mode indicators)
* Code diagnostics
* Locally available language documentation
* File explorer
* Git file history and Diff view
* Current file's per-line git change status
* Language Service Protocol integration
* Smart completion using LSP and other sources like local paths
* Improved movement
* Fancy notification framework
* Passive features like auto-pairing
* Saving and restoring sessions
* Quickly searching through various lists of items (files, lines, tags...)
* Pretty color schemes
* Language semantics-based parsing and highlighting via Treesitter
* Undo Tree
* Floating terminals and integrated floating apps
* Multiple-cursor support
* ...

## Notes

### Strikethrough

If strikethrough doesn't render correctly while using terminals that support it,
try the following:

```
infocmp $TERM > myterm.info
vim myterm.info # add `smxx=\E[9m, rmxx=\E[29m,`
tic -x myterm.info
```

[Source](https://github.com/neovim/neovim/discussions/24346#discussioncomment-9197378)

### Failure to Install `pylsp`

Run `sudo apt install python3-venv`
