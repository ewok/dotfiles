" GIT support
"
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'https://github.com/airblade/vim-gitgutter'
" Plug 'gregsexton/gitv'
Plug 'junegunn/gv.vim'
Plug 'jreybert/vimagit'

" Fugitive options
"
" shortcuts mapping
nnoremap <silent> <leader>gS :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gC :Gcommit<CR>
nnoremap <silent> <leader>gps :silent Git push<CR>
nnoremap <silent> <leader>gW :Gwrite<CR>
nnoremap <silent> <leader>gbl :Gblame<CR>
nnoremap <silent> <leader>gB :!open -a "DeepGit" --args "%:p" --line-number <C-r>=line('.')<CR><CR><CR>
nnoremap <silent> <leader>gR :Gread<CR>
nnoremap <silent> <leader>gplr :silent Git pull --rebase<CR>
nnoremap <silent> <leader>gpll :silent Git pull<CR>
nnoremap <silent> <leader>gg :Gbrowse<CR>
" nnoremap <silent> <leader>ge :Gedit<CR>

" Magit option
"
let g:magit_show_magit_mapping='<leader>gs'

" Gitgutter options
"
let g:gitgutter_map_keys = 0

" nmap <silent> <Leader>gS :GitGutterStageHunk<cr>
" nmap <silent> <Leader>gU :GitGutterUndoHunk<cr>

nmap [c <Plug>GitGutterPrevHunk
nmap ]c <Plug>GitGutterNextHunk

let g:gitgutter_override_sign_column_highlight = 0

" Gitv options
" nnoremap <silent> <leader>gH :Gitv<CR>
let g:Gitv_DoNotMapCtrlKey = 1
nnoremap <silent> <leader>gH :GV<CR>
