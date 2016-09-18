" Markdown support
" go get https://github.com/moorereason/mdfmt
call neobundle#append()
NeoBundle 'moorereason/vim-markdownfmt'
call neobundle#end()

let g:markdownfmt_command = 'mdfmt'
let g:markdownfmt_autosave=1
