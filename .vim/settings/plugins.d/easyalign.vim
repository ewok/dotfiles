" Align your code
"
call neobundle#append()
NeoBundle "junegunn/vim-easy-align"
call neobundle#end()

vnoremap <silent> <Enter> :EasyAlign<cr>
