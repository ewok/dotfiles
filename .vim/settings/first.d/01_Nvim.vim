" Settigns for nvim only
"
set inccommand=nosplit

let g:python3_host_prog = '/usr/local/bin/python3'
let g:python_host_prog = '/usr/local/bin/python2'

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

nmap <BS> <C-h>
tnoremap <Esc> <C-\><C-n>


if (has("termguicolors"))
    set termguicolors
endif
