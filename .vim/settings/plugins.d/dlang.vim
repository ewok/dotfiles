" DLang support
"
call neobundle#append()
NeoBundleLazy 'idanarye/vim-dutyl'
call neobundle#end()


augroup load_dutyl
  autocmd!
    autocmd FileType d NeoBundleSource vim-dutyl
                     \| autocmd! load_dutyl
    let g:dutyl_stdImportPaths=['/Library/D/dmd/src/druntime/import','/Library/D/dmd/src/phobos']
augroup END

