" Visual indent lines
"
Plug 'nathanaelkane/vim-indent-guides'

let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=237
hi IndentGuidesEven ctermbg=236

let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

if g:largefile != 1
    autocmd VimEnter * :IndentGuidesEnable
endif
