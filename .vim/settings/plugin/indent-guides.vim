call neobundle#append()
NeoBundle "nathanaelkane/vim-indent-guides"
call neobundle#end()

let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=237
hi IndentGuidesEven ctermbg=236


"set ts=4 sw=4 et
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

autocmd VimEnter * :IndentGuidesEnable