" Quick jump to buffet/mru/tag
"
call neobundle#append()
" NeoBundle "ctrlpvim/ctrlp.vim"
NeoBundle 'junegunn/fzf'
NeoBundle 'junegunn/fzf.vim'
call neobundle#end()

" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

let g:fzf_tags_command = 'ctags -R --exclude=.git --exclude=.idea --exclude=log'

nnoremap <silent> <leader>pt :Tags<cr>
nnoremap <silent> <leader>pp :Files<cr>
nnoremap <silent> <leader>pm :Marks<cr>

nnoremap <silent> <leader>gf :GFiles?<cr>
nnoremap <silent> <leader>gh :Commits<cr>
nnoremap <silent> <leader>gB :BCommits<cr>


command! -bang FT call fzf#vim#filetypes(<bang>0)
nnoremap <silent> <leader>ft :FT<cr>
" nnoremap <silent> <leader>ff :Ag<CR>

" Customize fzf colors to match your color scheme
" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] }

nnoremap <silent> <c-p><c-p> <nop>
nnoremap <silent> <c-p><c-t> <nop>
nnoremap <silent> <c-p><c-b> <nop>


