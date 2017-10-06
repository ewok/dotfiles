" Control your buffers
"
Plug 'jeetsukumaran/vim-buffergator', { 'on': 'BuffergatorToggle' }

let g:buffergator_suppress_keymaps=1
let g:buffergator_viewport_split_policy="B"

nnoremap <silent> <F4> :BuffergatorToggle<CR>
nnoremap <silent> <leader>pB :BuffergatorToggle<CR>
