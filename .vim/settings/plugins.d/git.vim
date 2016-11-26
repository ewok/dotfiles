" GIT support
"
call neobundle#append()
NeoBundle "tpope/vim-fugitive"
NeoBundle "shumphrey/fugitive-gitlab.vim"
NeoBundle "https://github.com/airblade/vim-gitgutter"
NeoBundle "gregsexton/gitv"
call neobundle#end()

" Fugitive options
"
" shortcuts mapping
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gC :Gcommit<CR>
nnoremap <silent> <leader>gps :Git push<CR>
nnoremap <silent> <leader>gW :Gwrite<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gR :Gread<CR>
nnoremap <silent> <leader>gplr :Git pull --rebase<CR>
nnoremap <silent> <leader>gplm :Git pull<CR>
nnoremap <silent> <leader>gg :Gbrowse<CR>
" nnoremap <silent> <leader>ge :Gedit<CR>

let g:Gitv_DoNotMapCtrlKey = 1
let g:fugitive_gitlab_domains = ['https://gitlab.kyc.megafon.ru']

" Gitgutter options
"
let g:gitgutter_map_keys = 0

nmap <silent> <Leader>gS :GitGutterStageHunk<cr>
nmap <silent> <Leader>gU :GitGutterUndoHunk<cr>

nmap [c <Plug>GitGutterPrevHunk
nmap ]c <Plug>GitGutterNextHunk

" Gitv options
nnoremap <silent> <leader>gH :Gitv<CR>
