call neobundle#append()
NeoBundle "tpope/vim-fugitive"
NeoBundle "shumphrey/fugitive-gitlab.vim"
call neobundle#end()

" shortcuts mapping
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gps :Git push<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gr :Gread<CR>
nnoremap <silent> <leader>gpl :Git pull --rebase<CR>
nnoremap <silent> <leader>gg :Gbrowse<CR>
nnoremap <silent> <leader>ge :Gedit<CR>

let g:Gitv_DoNotMapCtrlKey = 1
let g:fugitive_gitlab_domains = ['https://gitlab.kyc.megafon.ru']
