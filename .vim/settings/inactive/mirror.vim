" Remote edit and synchronize files
"
if has('nvim')
    call neobundle#append()
    NeoBundle "zenbro/mirror.vim"
    call neobundle#end()
endif

nnoremap <silent> <leader>me :MirrorEdit<CR>
nnoremap <silent> <leader>md :MirrorDiff<CR>
nnoremap <silent> <leader>mps :MirrorPush<CR>
nnoremap <silent> <leader>mpl :MirrorPull<CR>
nnoremap <silent> <leader>mo :MirrorOpen<CR>
nnoremap <silent> <leader>ms :MirrorSSH<CR>


" For multiple environments
nnoremap <silent> <leader>mE :MirrorEdit 
nnoremap <silent> <leader>mD :MirrorDiff 
nnoremap <silent> <leader>mpS :MirrorPush 
nnoremap <silent> <leader>mpL :MirrorPull 
nnoremap <silent> <leader>mO :MirrorOpen 
nnoremap <silent> <leader>mS :MirrorSSH 
