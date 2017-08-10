" Control your buffers
"
Plug 'jeetsukumaran/vim-buffergator'

let g:buffergator_suppress_keymaps=1
let g:buffergator_viewport_split_policy="B"

noremap <silent> <F4> :BuffergatorToggle<CR>
nnoremap <silent> <leader>pB :BuffergatorToggle<CR>
