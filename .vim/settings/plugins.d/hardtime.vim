call neobundle#append()
NeoBundle 'takac/vim-hardtime'
call neobundle#end()

let g:hardtime_ignore_quickfix = 1
let g:hardtime_ignore_buffer_patterns = [ "NERD.*", "magit*" ]
let g:hardtime_default_on = 1
let g:hardtime_timeout = 500
let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+"]
let g:list_of_visual_keys = ["h", "j", "k", "l", "-", "+"]
let g:list_of_insert_keys = []
let g:list_of_disabled_keys = []

