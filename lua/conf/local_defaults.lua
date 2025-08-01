-- vim overall colorscheme, options are:
--   "nord", "catppuccin", "kanagawa", "github_dark", "tokyonight",
--   "everforest", "gruvbox-material", or "random"
vim.g.theme = "catppuccin"

-- Visuals
-- Animate the cursor dashing across the screen with a smear effect
vim.g.smear_cursor = false
-- Animate scrolling
vim.g.animate_scroll = false
-- Scrollbar
vim.g.enable_scrollbar = true
-- Highlight "TODO" and other comments
vim.g.enable_todo_highlights = false
-- Git diff gutter
vim.g.enable_git_signs = true
-- Highlight (other instances of) word under cursor
vim.g.highlight_word_under_cursor = true
-- Transparent background (still requires toggling)
vim.g.enable_transparency = false
-- Rainbow delimiters and indentation
vim.g.enable_rainbow_paren = true
vim.g.enable_rainbow_indent = true
-- Crossout line in DiffDelete
vim.g.crossout_diff_delete = false
-- Peek line number
vim.g.enable_peek_line_number = true
-- Prevent LSP from also highlighting references to word under cursor
vim.g.prevent_lsp_cursor_highlight = true
-- Compatibility mode for nerd font
vim.g.nerdfont_v2_compat = false
-- Visual mode provides word count (line, word, char)
vim.g.visual_wordcount = true

-- Features
-- Enable sophisticated notifications via noice
vim.g.enable_noice = true
-- Enable sophisticated folding via ufo
vim.g.enable_ufo = true
-- Run hover when hovering
vim.g.do_hover = false
-- Automatically fix whitespaces at file save
vim.g.auto_cleanup_whitespace = true
-- Automatically detect filetype at file save if none set yet
vim.g.detect_filetype_on_save = true
-- Save oldfiles to /tmp/oldfiles.txt separately from shada
vim.g.save_oldfiles = false
-- Automatically toggle between CN/EN ime on escape/insert
vim.g.auto_toggle_ime = false
-- Do not yank content deleted via x/X/s/c...
vim.g.no_yank_deletion = true
-- Keep window open after split kill
vim.g.keep_win_after_bufkill = true
-- Enable folke.which-key
vim.g.enable_which_key = false
-- Cleanup unused user commands
vim.g.cleanup_usercmds = true
-- Last buffer close behavior (quit, empty, dash, yazi)
vim.g.last_buffer_close_action = "dash"
-- Use customized safe incremental selection instead of nvim's built-in
vim.g.use_safe_incremental_selection = false

-- Typing preferences
-- pressing escape will *clear* temporarily selected completion items, instead
-- of leaving it written. `false` is nvim-cmp previous behavior.
vim.g.escape_clears_cmp = false

-- Lsp preferences
-- Whether to use fzf for lsp selector
vim.g.use_fzf_for_lsp = true
