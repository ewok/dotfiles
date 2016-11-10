" QuickFix Window, which is borrowed from c9s
command -bang -nargs=? QFix call QFixToggle(<bang>0)

function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win=bufnr("$")
  endif
endfunction


autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")

nnoremap <leader>qf :QFix<CR>
nnoremap <leader>qo :copen<CR>
nnoremap <leader>qc :cclose<CR>
