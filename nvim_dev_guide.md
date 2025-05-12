# Neovim Workflow

If you are a user of Neovim, you can run vim and make use of a number of
already-installed tools (notably, `bear` and `clangd`) available on spoc to
make your time developing in c, even over ssh, a nicer time.

## General Policies

Please also remember your pledge. The various LLM code-generation plugins such
`llm.nvim`, `ChatGPT.nvim`, `avante.nvim` are strictly prohibited from this course.

## Neovim Installation

Students do not have root access on `spoc`, so you'd need to get precompiled
binaries for Neovim.

For convenience, see [Additional Tools](#additional-tools).

## Neovim Config

### Existing User / Coming from Vim

If you are a long term user of neovim with your own `init.lua` and plugin setup,
then most of this should be fairly familiar.

If you are from vim:
Most of Vim's settings and keybinds are drop-in with Neovim, but not vice versa,
so by using Neovim you'll get to keep your muscle memory of the editor while
enjoying some new features (hopefully!).

#### Plugins

While the neovim available on the host is only v0.6, if you use the script
provided below to fetch Neovim, it will be version 0.11 at least, which means
it will have native support for configuring LSPs, so the configuration will
be quite simple. Assuming you already use `lazy.nvim`, I will directly produce
the specs below -- though you should obviously tweak them to your own liking.
Alternatively, you can review the author's customized repo branch with all the
following configs plus some extra [here](#starter-config).

Note: ALL of these are optional -- you can include or exclude parts based on
what you can effectively make use of.

First, the `init.lua` config file itself, which includes the bare minimum of
plugin bootstrapping, some minimal settings, and configuring the LSP and
completion.

```lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- conform, for invoking formating.
    {
      "stevearc/conform.nvim",
      config = function()
        local conform = require("conform")
        conform.setup({
          default_format_opts = {
            lsp_format = "prefer",
          },
        })
        vim.keymap.set("n", "<leader>fc", function()
          conform.format({ async = true })
        end)
      end,
    },

    -- diagnostics
    {
      "rachartier/tiny-inline-diagnostic.nvim",
      priority = 1000, -- needs to be loaded in first
      config = function()
        require('tiny-inline-diagnostic').setup()
      end
    },

    -- navigational breadcrumbs on the top
    {
      event = { "BufReadPost", "BufNewFile", "BufWritePre" },
      "SmiteshP/nvim-navic",
      dependencies = "neovim/nvim-lspconfig",
      opts = {
        lsp = {
          auto_attach = true,
        }
      },
      config = true,
    },

    -- code actions (provided by the lsp)
    {
      "rachartier/tiny-code-action.nvim",
      dependencies = {
        { "nvim-lua/plenary.nvim" },
        -- optional picker via fzf-lua
        { "ibhagwan/fzf-lua" },
      },
      event = "LspAttach",
      config = function()
        local tca = require("tiny-code-action")
        tca.setup({
          picker = "select",
        })
        vim.keymap.set("n", "<leader>ca", function()
          tca.code_action()
        end, { noremap = true, silent = true })
      end,
    },

    -- key hints
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
    },

    -- a nice colorscheme
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

    -- completions
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "PhilippFeO/cmp-help-tags",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",
    "rafamadriz/friendly-snippets",

    -- add your plugins here
  },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- some basic settings
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.numberwidth = 3 -- 1 is used for a space though
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.termguicolors = true
vim.cmd.colorscheme("catppuccin")

-- lsp setup
local fzf = require("fzf-lua")
local core_lsps = { "clangd" }
vim.lsp.enable(core_lsps)

-- LSP dedicated key mappings
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.lsp.inlay_hint.enable(true)

    -- these will be buffer-local keybindings
    -- because they only work if you have an active language server
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    vim.keymap.set("n", "gd", fzf.lsp_declarations, opts)
    vim.keymap.set("n", "gf", fzf.lsp_definitions, opts)
    vim.keymap.set("n", "gi", fzf.lsp_implementations, opts)
    vim.keymap.set("n", "gt", fzf.lsp_typedefs, opts)
    vim.keymap.set("n", "gr", fzf.lsp_references, opts)
    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
    vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  end,
})

-- symbols
vim.fn.sign_define("DiagnosticSignError", { text = "X", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "!", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "?", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "i", texthl = "DiagnosticSignHint" })

-- Completion configurations

---@diagnostic disable: missing-fields

local cmp = require("cmp")

vim.g.vsnip_snippet_dir = "$VIM_HOME/snippets"

table.unpack = table.unpack or unpack

local has_words_before = function()
  local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "vsnip" },
    {
      name = "lazydev",
      group_index = 0, -- set group index to 0 to skip loading LuaLS completions
    },
  }, {
    { name = "buffer" },
    { name = "path" },
    { name = "calc" },
  }),
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      local has_words = has_words_before()
      -- enables typing multiple tabs even if autocomplete already triggered.
      -- why the hell is autocomplete triggering on empty stuff though?
      if cmp.visible() and has_words then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable,
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Up>"] = cmp.mapping(function(fallback)
      local has_words = has_words_before()
      -- enables typing multiple tabs even if autocomplete already triggered.
      -- why the hell is autocomplete triggering on empty stuff though?
      if cmp.visible() and has_words then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<Down>"] = cmp.mapping(function(fallback)
      local has_words = has_words_before()
      -- enables typing multiple tabs even if autocomplete already triggered.
      -- why the hell is autocomplete triggering on empty stuff though?
      if cmp.visible() and has_words then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  },
})

-- lang specific
cmp.setup.filetype("sh", {
  sources = cmp.config.sources({
    { name = "path" },
    { name = "vsnip" },
  }),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})
```

At the end, your `$HOME/.config/nvim` should have the following structure:

```
.
├── init.lua
└── lazy-lock.json  <--- (if you already ran nvim after add init.lua)
```

### Brand new Vimmer

There are a number of starter templates and setup packs for neovim, which are
essentially pre-configured settings and plugin-sets that can be used by simply
including the spec files. That said, you _will_ have to learn both Neovim _and_
any additional features from scratch. It would be a pretty valuable tool though!

There are a number of starter kits for new users, but I would recommend
something like [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) to,
well, _kickstart_ your neovim journey. OR just look the above basic `init.lua`,
and start yours by incrementally adding more stuff to it based on how you want
your vim config to be!

For reference (but probably not for direct adoption -- you certainly can, but
be warned that you likely will struggle some amount of time learning the ropes),
here are some popular finished setups:

- [LazyVim](https://www.lazyvim.org/)
- [LunarVim](https://www.lunarvim.org/)
- [AstroVim](https://astronvim.com/)

We will not be spending time going through how Neovim itself works, or how to
configure plugins for Neovim.


## Workflow

For each project repo, you can create a `.clang-format` file, which will
instruct `clang-tidy` as to how the formatting should be done. While unlike
CS4118, CS4157 does not have a formatting style enforced, it is still good
to ensure some consistency wrt to code style, e.g. [clang format for linux kernel](https://raw.githubusercontent.com/jonasblixt/punchboot/refs/heads/master/.clang-format).
This lets `clangd`/`clang-tidy`/`clang-format` knows how you want your files
formatted.

For each Makefile, when you would run `make`, you instead run `bear -- make`
to generate a `compile_commands.json` file, which is referred to by clangd as a
compile database. This file itself can be added to gitignore, as it is mostly
local information about how your compiler is finding the necessary libs and
files. Clangd can then use the same information to give you language intel, such
as function signatures, symbol definitions, references, incoming/outgoing calls,
etc. Note: you would only need to create this `compile_commands.json` file once
for each Makefile, until you make some build rule changes that would invalidate
its content, e.g. bringing in new file dependencies, etc.

Then inside neovim, having installed the afore mentioned plugins, you should
get:

- Diagnostics in the forms of little colored icons in the gutter (the leftmost
  column next to the line numbers) signaling issues with your code. When your
  cursor hovers on that line, you will get a floating virtual text telling you
  what is wrong. Sometimes it might even have code actions that you can invoke
  to try to automatically fix it. This would save you from having to repeatedly
  recompile just to find errors.
- Inlay hints: virtual text that tells you _which_ parameter is which in a
  function, e.g. instead of `read(c_args->channel, &c, 1)`, you see
  `read(fd: c_args->channel, buf: &c, nbytes: 1)`, where `fd`, `buf` and
  `nbytes` are virtual text intended to show you which variables your parameters
  map to in the function signature.
- Code intelligence -- signatures (`K` when hovering), go to definition (`gd`),
  list and goto references (`gr`).
- Autocompletion: autocomplete using LSP information.
- Code Action: `<leader>ca` to perform recommended action by the LSP,
  `<leader>rn` to rename a symbol. (Where supported)
- Formatting: `<leader>fc`. Add your own preferred mappings for it!
- Misc: It can also do things like grey-out variables and include statements
  that you have but are not using.

### Testing

For running tests, while there are plenty of plugins for running jobs for you,
I instead recommend you learn [tmux](https://github.com/tmux/tmux/wiki) if you
haven't already, or [zellij](zellij.dev) if you are the more adventurous type.

At the very least, you can just run `:!` in neovim itself to invoke commands in
the shell. Plenty of plugins or actual native functions also exist that allows
you to have a persistent terminal in neovim, which we will not dive into.

### Debugging

Jae recommends that you rely less on debuggers and more on logical thinking
and effective usage of `printf` debugging in these earlier courses :P

(That said, `nvim-dap` is a thing, which again we will not go into.)

## Additional Tools

### Starter Config

This is the [author's own config](https://github.com/tzhouhc/vim/tree/cs4157),
but with significant amount of personalization removed, which is still a lot
of extra stuff on top of the basic `init.lua` config above.

### Nerdfont

If instead of the minimal `init.lua` above you instead decide to go for the
sample repo or some other more sophisticated setup, in order to get the nice
shiny little icons, you should install a font with
[NerdFont](https://www.nerdfonts.com/) support.

My personal favorite has been [Cascadia Code](https://github.com/microsoft/cascadia-code/releases/tag/v2407.24)
as it includes NF and a lot of other miscellaneous glyphs.

### Getting Neovim

Use [This script](https://github.com/tzhouhc/dotfiles/blob/main/.dotfiles/install/core/nvim.sh)
or run

```bash
curl -s \
https://raw.githubusercontent.com/tzhouhc/dotfiles/0754fe2f38e5e60e2514c82ef8d5f455c41ffa69/.dotfiles/install/core/nvim.sh \
| bash
```

if you are feeling lucky :)

> [!NOTE]
> Once installed, you will also need to follow the instructions from the script
> to add the `nvim` binary to your `PATH` environment variable.

### Binary Diff

Not actually related to setting up neovim!

Conveniently, `delta` and `hexyl` are also available. If you ever find yourself
in the particular situation of wanting to compare two binary files byte-by-byte,
here's a simple script you can use to do so.

```bash
#!/usr/bin/env bash

if ! type hexyl &>/dev/null; then
  echo "hexyl not found"
  exit 1
fi

tmpa=$(mktemp /tmp/diff_temp.XXXXXX)
tmpb=$(mktemp /tmp/diff_temp.XXXXXX)

hexyl -p "$1" > "$tmpa"
hexyl -p "$2" > "$tmpb"

if type delta &>/dev/null; then
  delta "$tmpa" "$tmpb"
else
  diff "$tmpa" "$tmpb"
fi

rm "$tmpa"
rm "$tmpb"
```
