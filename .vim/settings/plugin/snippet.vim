call neobundle#append()
" NeoBundle "Shougo/neosnippet-snippets"
" NeoBundle "Shougo/neosnippet.vim"
NeoBundle "SirVer/ultisnips"
NeoBundle "honza/vim-snippets"
NeoBundle "kiith-sa/DSnips"
call neobundle#end()

" let g:UltiSnipsExpandTrigger="<enter>"
" let g:UltiSnipsJumpForwardTrigger="<c-n>"
" let g:UltiSnipsJumpBackwardTrigger="<c-p>"

let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsExpandTrigger="<nop>"
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
