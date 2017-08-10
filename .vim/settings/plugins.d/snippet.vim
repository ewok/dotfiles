" Snippets
"
" Plug 'Shougo/neosnippet-snippets'
" Plug 'Shougo/neosnippet.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'kiith-sa/DSnips'

" let g:UltiSnipsExpandTrigger="<enter>"
" let g:UltiSnipsJumpForwardTrigger="<c-n>"
" let g:UltiSnipsJumpBackwardTrigger="<c-p>"

" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
" let g:UltiSnipsExpandTrigger="<nop>"
let g:ulti_expand_or_jump_res      = 0

function! <SID>ExpandSnippetOrReturn()
  let snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return snippet
  else
    return "\<CR>"
  endif
endfunction

inoremap <expr> <CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "\<CR>"
