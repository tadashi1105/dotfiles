"=============================================================================
" vim-airline/vim-airline
" URL: https://github.com/vim-airline/vim-airline
"=============================================================================

let g:airline_theme='nord'

" Tab line
let g:airline#extensions#tabline#enabled = 1

" Powerline symbols
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.colnr = ' '
let g:airline_symbols.linenr = ' '
let g:airline_symbols.maxlinenr = ''