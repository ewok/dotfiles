" Grep in project
"
call neobundle#append()
if has('nvim')
    " NeoBundle "eugen0329/vim-esearch"
else
    NeoBundle "mileszs/ack.vim"
endif
call neobundle#end()

if has('nvim')
else

    " if silver searcher is installed, use `ag` instead of `ack`
    if executable("ag")
        let g:ackprg = 'ag --nogroup --nocolor --column'
        noremap <leader>ff :Ack<SPACE>
        nnoremap <leader>vv :Ack <cword><CR>
    else
        if executable("ack")
            noremap <leader>ff :Ack<SPACE>
            nnoremap <leader>vv :Ack <cword><CR>
        else
            noremap <leader>ff :echo "Sorry, you need to install ack or ag first!"<CR>
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
endif
