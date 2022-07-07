"=============================================================================
" junegunn/vim-plug
" URL: https://github.com/junegunn/vim-plug
"=============================================================================

" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  let s:install_vim_plug = confirm("vim-plug not installed, install now?", "Yes\nNo", 2)
  if s:install_vim_plug == 1
    echo 'Install vim-plug...'
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    echo 'Done!'
  endif
endif

if empty(glob(data_dir . '/autoload/plug.vim')) | finish | endif

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Colorscheme
Plug 'arcticicestudio/nord-vim', { 'do': ':runtime after/plugin/nord-vim.rc.vim' }

" Status line
Plug 'itchyny/lightline.vim'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" Git
Plug 'tpope/vim-fugitive'

if has('nvim') && has('nvim-0.5.0')
  Plug 'windwp/nvim-autopairs'
endif

if !has('nvim')
  Plug 'LunarWatcher/auto-pairs'
endif

" Initialize plugin system
call plug#end()
