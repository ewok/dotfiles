" Settigns for nvim only
"
if has('nvim')
    let g:python3_host_prog = '/usr/local/bin/python3'
    let g:python_host_prog = '/usr/local/bin/python2'
    set inccommand=nosplit

    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif

if (has("termguicolors"))
    set termguicolors
endif
