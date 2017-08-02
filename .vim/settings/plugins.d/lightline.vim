" Lightline
"
call neobundle#append()
NeoBundle "itchyny/lightline.vim"
call neobundle#end()

if !has('gui_running')
  set t_Co=256
endif

let g:lightline = {
      \ 'colorscheme': 'neodark',
      \ }
