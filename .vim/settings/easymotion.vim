call neobundle#append()
NeoBundle "easymotion/vim-easymotion"
call neobundle#end()

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap ss <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
"
" Need one more keystroke, but on average, it may be more comfortable.
" nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" Gif config
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" Gif config
map sl <Plug>(easymotion-lineforward)
map sj <Plug>(easymotion-j)
map sk <Plug>(easymotion-k)
map sh <Plug>(easymotion-linebackward)
