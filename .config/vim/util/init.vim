"=============================================================================
" Utils
"=============================================================================

function! s:DefineUnicodeSpaceSyntax() abort
  syntax match UnicodeSpace /\%u2000\|\%u2001\|\%u2002\|\%u2003\|\%u2004\|\%u2005\|\%u2006\|\%u2007\|\%u2008\|\%u2009\|\%u200A\|\%u2028\|\%u2029\|\%u205F\|\%u3000/
  highlight default UnicodeSpace term=reverse ctermfg=15 ctermbg=9 guifg=White guibg=Red
endfunction

function! s:ToggleInvisibleCharacters() abort
  set list!
  syntax clear UnicodeSpace
  if &list
    call s:DefineUnicodeSpaceSyntax()
  endif
endfunction

call s:DefineUnicodeSpaceSyntax()

augroup my_highlight
  autocmd!
  autocmd BufWinEnter, ColorScheme * call s:DefineUnicodeSpaceSyntax()
augroup END

" Toggle list mode and highlight Unicode white space characters
nnoremap <silent> <Leader>;tl :call <SID>ToggleInvisibleCharacters()<CR>
