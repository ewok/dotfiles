" DLang support
"
Plug 'idanarye/vim-dutyl', { 'for': 'd'  }

autocmd! User vim-dutyl call Load_dutyl()

function! Load_dutyl()
    let g:dutyl_stdImportPaths=['/Library/D/dmd/src/druntime/import','/Library/D/dmd/src/phobos']
endfunction
