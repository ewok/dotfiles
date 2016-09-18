" Auto input switcher
"
call neobundle#append()
NeoBundle "lyokha/vim-xkbswitch"
call neobundle#end()

" git clone https://github.com/vovkasm/input-source-switcher.git
" cd input-source-switcher
" mkdir build && cd build
" cmake ..
" make
" make install
"
let g:XkbSwitchLib = '/usr/local/lib/libInputSourceSwitcher.dylib'

let g:XkbSwitchEnabled = 1
let g:XkbSwitchSkipFt = [ 'nerdtree' ]

