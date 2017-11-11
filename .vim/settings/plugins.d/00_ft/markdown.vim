" MarkDown
"
Plug 'godlygeek/tabular', { 'for': 'markdown' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'shime/vim-livedown', { 'for': 'markdown', 'do': ':!npm install -g livedown' }

let g:livedown_browser = 'Safari'
" let g:livedown_autorun = 1
let g:livedown_port = 14545
