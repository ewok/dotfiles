" Quick jump to buffet/mru/tag
"
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

let g:fzf_tags_command = 'ctags -R --exclude=.git --exclude=.idea --exclude=log'

nnoremap <silent> <leader>pt :Tags<cr>
nnoremap <silent> <leader>pp :Files<cr>
nnoremap <silent> <leader>pm :Marks<cr>
nnoremap <silent> <leader>pb :Buffers<cr>
nnoremap <silent> <leader>pf :Filetypes<cr>

nnoremap <silent> <leader>gf :GFiles?<cr>
nnoremap <silent> <leader>gh :Commits<cr>
nnoremap <silent> <leader>gbc :BCommits<cr>


command! -bang FT call fzf#vim#filetypes(<bang>0)
nnoremap <silent> <leader>ft :FT<cr>
nnoremap <silent> <leader>ff :Ag<CR>

nnoremap <silent> <c-p><c-p> <nop>
nnoremap <silent> <c-p><c-t> <nop>
nnoremap <silent> <c-p><c-b> <nop>

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
