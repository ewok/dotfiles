" Neomake(like Syntastic)
" (neovim only)
"
if has('nvim')
    Plug 'benekastah/neomake', { 'for': ['go', 'python', 'd', 'bash', 'ansible', 'sh'] }
    autocmd! User neomake call LoadNeomake()

    function! LoadNeomake()
        function! NeomakeIfModified()
            if &modified > 0
                Neomake
            endif
        endfunction
        autocmd! BufWritePre go,python,d,bash,ansible,sh call NeomakeIfModified()
        autocmd! BufEnter go,python,d,bash,ansible,sh Neomake
    endfunction
endif
