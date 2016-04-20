call neobundle#append()
NeoBundle "jeetsukumaran/vim-buffergator"
call neobundle#end()

let g:buffergator_suppress_keymaps=1
let g:buffergator_viewport_split_policy="B"

noremap <silent> <F4> :BuffergatorToggle<CR>
