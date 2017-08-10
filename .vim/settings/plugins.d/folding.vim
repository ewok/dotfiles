" Fold any code
"
Plug 'pseewald/vim-anyfold'

if g:largefile != 1
    autocmd Filetype python,ansible,puppet,go,xml,json,sh,zsh let b:anyfold_activate=1
endif


nnoremap <silent> <leader><Space> zA
