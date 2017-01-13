" Neomake(like Syntastic)
" (neovim only)
"
if has('nvim')
    call neobundle#append()
    NeoBundle "benekastah/neomake"
    call neobundle#end()
    " autocmd! BufWritePost * Neomake
    autocmd! BufWritePost,BufEnter * Neomake
endif

