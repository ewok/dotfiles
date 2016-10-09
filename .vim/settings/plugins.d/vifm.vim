" Vifm filemanager support
"
call neobundle#append()
if has('nvim')
    NeoBundle "vifm/neovim-vifm"
else
    NeoBundle "vifm/vifm.vim"
endif
call neobundle#end()
