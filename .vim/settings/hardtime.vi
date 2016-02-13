call neobundle#append()
NeoBundle "https://github.com/wikitopian/hardmode.git"
NeoBundle "https://github.com/takac/vim-hardtime.git"
call neobundle#end()

autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
let g:HardMode_level='wannabe'

" If set to 'wannabe' arrow keys disabled, but not hjkl etc.
" let g:hardtime_ignore_buffer_patterns = [ 'NERD.*' ]
" let g:hardtime_ignore_quickfix = 1
" let g:hardtime_maxcount = 4
" let g:hardtime_default_on = 1
" Slow down hjkl keys
" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardTimeOn()
