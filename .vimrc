"=============================================================================
" tadashi1105's .vimrc
"=============================================================================

" Note: Skip initialization for vim-tiny or vim-small
if !1 | finish | endif

set runtimepath^=~/.config/vim

" Load config files
runtime options.vim
runtime keymaps.vim
runtime autocmds.vim

" Load plugin
runtime! before/plugin/*.rc.vim
runtime plug.vim
runtime! after/plugin/*.rc.vim

runtime! util/*.vim
