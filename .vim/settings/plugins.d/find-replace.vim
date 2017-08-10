" Find and Replace

Plug 'brooth/far.vim'

if has('nvim')
    let g:far#source = 'agnvim'
endif

let g:far#file_mask_favorites = ['%', '.*', '\.py$', '\.go$']

nnoremap <leader>fr :Far<space>
vnoremap <leader>fr :Far<space>

