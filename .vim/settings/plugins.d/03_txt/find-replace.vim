" Find and Replace
"
Plug 'brooth/far.vim'

let g:far#source = 'agnvim'
let g:far#file_mask_favorites = ['%', '.*', '\.py$', '\.go$']

nnoremap <leader>fr :Far<space>
vnoremap <leader>fr :Far<space>

