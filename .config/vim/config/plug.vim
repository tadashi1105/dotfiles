"=============================================================================
" junegunn/vim-plug
" URL: https://github.com/junegunn/vim-plug
"=============================================================================

" Install vim-plug if not found
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  let s:install_vim_plug = confirm("vim-plug not installed, install now?", "Yes\nNo", 2)
  if s:install_vim_plug == 1
    echo 'Install vim-plug...'
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    echo 'Done!'
  endif
endif

if empty(glob(data_dir . '/autoload/plug.vim')) | finish | endif
if !exists('g:loaded_plug')
  silent execute 'source' fnameescape(resolve(expand(data_dir . '/autoload/plug.vim'))) 
endif

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Colorscheme
Plug 'nordtheme/vim', { 'as': 'nord.vim' }
Plug 'folke/tokyonight.nvim', { 'rtp': 'extras/vim' }

" Status line
Plug 'itchyny/lightline.vim'

" Git
Plug 'tpope/vim-fugitive'

" Edit
Plug 'LunarWatcher/auto-pairs'

" Initialize plugin system
call plug#end()
