" Sessions
"
let g:sessiondir = $HOME . "/.vim/sessions"

function! MakeSession(file)

  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
  exe ':tabdo NERDTreeClose'
  endif
  exe ':lclose|cclose'

  let file = a:file

  if (file == "")
      if (exists('g:sessionfile'))
          let b:sessiondir = g:sessiondir
          let file = g:sessionfile
      else
          let b:sessiondir = g:sessiondir . getcwd()
          let file = "session"
      endif
  else
      let b:sessiondir = g:sessiondir
      let g:sessionfile = file
  endif

  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/' . file . '.vim'

  exe "silent mksession! " . b:filename
endfunction

function! LoadSession(file)

  let file = a:file

  if (file == "")
      if (exists('g:sessionfile'))
          let b:sessiondir = g:sessiondir
          let file = g:sessionfile
      else
          let b:sessiondir = g:sessiondir . getcwd()
          let file = "session"
      endif
  else
      let b:sessiondir = g:sessiondir
      let g:sessionfile = file
  endif

  let b:sessionfile = b:sessiondir . '/' . file . '.vim'
  if (filereadable(b:sessionfile))
    exe 'silent source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

function! DeleteSession(file)

  let file = a:file

  if (file == "")
      if (exists('g:sessionfile'))
          let b:sessiondir = g:sessiondir
          let file = g:sessionfile
      else
          let b:sessiondir = g:sessiondir . getcwd()
          let file = "session"
      endif
  else
      let b:sessiondir = g:sessiondir
  endif

  let b:sessionfile = b:sessiondir . '/' . file . '.vim'
  if (filereadable(b:sessionfile))
    exe 'silent !rm -f ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

function! CloseSession()
  if (exists('g:sessionfile'))
    call MakeSession(g:sessionfile)
    unlet g:sessionfile
  else
    call MakeSession("")
  endif
    exe 'silent wa | %bd!'
endfunction

function! CloseSessionAndExit()
    call CloseSession()
    exe 'silent qa'
endfunction

fun! ListSessions(A,L,P)
    return system("ls " . g:sessiondir . ' | grep .vim | sed s/\.vim$//')
endfun

command! -nargs=1 -range -complete=custom,ListSessions MakeSession :call MakeSession("<args>")
command! -nargs=1 -range -complete=custom,ListSessions LoadSession :call LoadSession("<args>")
command! -nargs=1 -range -complete=custom,ListSessions DeleteSession :call DeleteSession("<args>")
command! MakeSessionCurrent :call MakeSession("")
command! LoadSessionCurrent :call LoadSession("")
command! DeleteSessionCurrent :call DeleteSession("")
command! CloseSession :call CloseSession()
command! CloseSessionAndExitCurrent :call CloseSessionAndExit()

nnoremap <leader>so :LoadSession<SPACE>
nnoremap <leader>su :LoadSessionCurrent<CR>
nnoremap <leader>ss :MakeSessionCurrent<CR>
nnoremap <leader>sq :CloseSessionAndExit<CR>
nnoremap <leader>sx :CloseSession<CR>
nnoremap <leader>sk :DeleteSessionCurrent<CR>
