"=============================================================================
" Filetype
"=============================================================================

" Set filetype
autocmd BufRead,BufNewFile *.{bowerrc,csslintrc,eslintrc,babelrc} setlocal filetype=json
autocmd BufRead,BufNewFile *.md setlocal filetype=markdown
