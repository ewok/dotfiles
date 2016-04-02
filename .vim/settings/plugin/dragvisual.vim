call neobundle#append()
NeoBundle 'zirrostig/vim-schlepp'
call neobundle#end()

vmap <unique> <up>    <Plug>SchleppUp
vmap <unique> <down>  <Plug>SchleppDown
vmap <unique> <left>  <Plug>SchleppLeft
vmap <unique> <right> <Plug>SchleppRight
