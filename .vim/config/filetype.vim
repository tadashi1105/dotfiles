"=============================================================================
" Filetype
"=============================================================================

" Set filetype
autocmd BufRead,BufNewFile *.{bowerrc,csslintrc,eslintrc,babelrc} setlocal filetype=json
autocmd BufRead,BufNewFile *.{md,mdwn,mdown,mkd,mkdn,markdown} setlocal filetype=markdown
