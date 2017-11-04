" Neomake(like Syntastic)
" (neovim only)
"
Plug 'w0rp/ale'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
" pip2 install pylint mypy flake8 ansible-lint yamllint

    " Plug 'neomake/neomake', { 'for': ['go', 'python', 'd', 'bash', 'ansible', 'sh', 'vim'] }
    " autocmd! User neomake call LoadNeomake()

    " function! LoadNeomake()
    "     function! NeomakeIfModified()
    "             Neomake
    "     endfunction
    "     " autocmd! BufWritePre go,python,d,bash,ansible,sh call NeomakeIfModified()
    "     " autocmd! BufEnter go,python,d,bash,ansible,sh Neomake
    "     autocmd FileType go,python,d,bash,ansible,sh autocmd BufWrite <buffer> call NeomakeIfModified()
    " endfunction
