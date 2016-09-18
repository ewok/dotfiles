" Morph your text
"
call neobundle#append()
NeoBundleLazy "d0c-s4vage/vim-morph"
call neobundle#end()

command! MorphEnable silent :NeoBundleSource vim-morph|delcommand MorphEnable
