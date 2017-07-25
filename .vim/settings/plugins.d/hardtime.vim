call neobundle#append()
NeoBundle 'takac/vim-hardtime'
call neobundle#end()

let g:hardtime_ignore_quickfix = 1
let g:hardtime_ignore_buffer_patterns = [ "NERD.*", "magit*" ]
let g:hardtime_default_on = 1
let g:hardtime_timeout = 500

