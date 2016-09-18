" Grep in project
"
call neobundle#append()
NeoBundle "mileszs/ack.vim"
call neobundle#end()

" if silver searcher is installed, use `ag` instead of `ack`
if executable("ag")
  let g:ackprg = 'ag --nogroup --nocolor --column'
  noremap FF :Ack<SPACE>
  nnoremap <leader>vv :Ack <cword><CR>
else
  if executable("ack")
    noremap FF :Ack<SPACE>
  nnoremap <leader>vv :Ack <cword><CR>
  else
    noremap FF :echo "Sorry, you need to install ack or ag first!"<CR>
  endif
endif

let g:ack_mappings = {
      \ "t": "<C-W><CR><C-W>T",
      \ "T": "<C-W><CR><C-W>TgT<C-W>j",
      \ "o": "<CR>",
      \ "O": "<CR><C-W><C-W>:ccl<CR>",
      \ "p": "<CR><C-W>j",
      \ "h": "<C-W><CR><C-W>K",
      \ "H": "<C-W><CR><C-W>K<C-W>b",
      \ "v": "<C-W><CR><C-W>H<C-W>b<C-W>J<C-W>t",
      \ "gv": "<C-W><CR><C-W>H<C-W>b<C-W>J"
      \ }
