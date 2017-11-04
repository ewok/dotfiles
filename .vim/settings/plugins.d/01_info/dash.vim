" Dash integration
"
Plug 'rizzatti/dash.vim'

nnoremap <F1> :set isk+=.<CR>:Dash <cword><CR>:set isk-=.<CR>
inoremap <F1> <ESC>:set isk+=.<CR>:Dash <cword><CR>:set isk-=.<CR>a
