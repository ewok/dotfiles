if has('nvim')
    call neobundle#append()
    NeoBundle "benekastah/neomake"
    call neobundle#end()
    autocmd! BufWritePost * Neomake

endif

