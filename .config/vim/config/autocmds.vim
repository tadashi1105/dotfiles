"=============================================================================
" Aurocmds
"=============================================================================

" Quit buffer
augroup my_close_with_q
  autocmd!
  autocmd FileType help nnoremap <buffer> q :helpclose<CR>
  autocmd FileType qf nnoremap <buffer> q :cclose<CR>
augroup END
