
call neobundle#append()
NeoBundle "rizzatti/dash.vim"
call neobundle#end()

nnoremap <F1> :set isk+=.<CR>:Dash <cword><CR>:set isk-=.<CR>
inoremap <F1> <ESC>:set isk+=.<CR>:Dash <cword><CR>:set isk-=.<CR>a
