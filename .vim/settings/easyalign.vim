call neobundle#append()
NeoBundle "junegunn/vim-easy-align"
call neobundle#end()

" Easy align interactive
vnoremap <silent> <Enter> :EasyAlign<cr>
