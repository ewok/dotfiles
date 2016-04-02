if has('nvim')
else
    call neobundle#append()
    NeoBundle "https://github.com/jmcantrell/vim-virtualenv.git"
    call neobundle#end()

    let g:virtualenv_directory = "~/share"
endif
