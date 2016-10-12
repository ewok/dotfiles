" Haskell support
"
call neobundle#append()
NeoBundle "eagletmt/ghcmod-vim"
NeoBundle "bitc/vim-hdevtools"
NeoBundle "Twinside/vim-hoogle"
NeoBundle "eagletmt/neco-ghc"
NeoBundle "neovimhaskell/haskell-vim"
" NeoBundle "nbouscal/vim-stylish-haskell"
" Useless
" NeoBundle "enomsg/vim-haskellConcealPlus"
" Experiment
" NeoBundle "ervandew/supertab"
call neobundle#end()

" Automatically make cscope connections
function! LoadHscope()
  let db = findfile("hscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/hscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /*.hs call LoadHscope()

function! LoadHaskell()

  if exists("b:did_ftplugin_b")
    return
  endif
  let b:did_ftplugin_b = 1

  " set smartindent

  " map <buffer> <leader>tu :!codex update --force<CR>:call system("git-hscope -X TemplateHaskell")<CR><CR>:call LoadHscope()<CR>
  map <buffer> <leader>tu :!hasktags --ignore-close-implementation --ctags .; sort tags<CR>:call system("git-hscope -X TemplateHaskell")<CR><CR>:call LoadHscope()<CR>

  " Disable haskell-vim omnifunc
  let b:haskellmode_completion_ghc = 0
  setlocal omnifunc=necoghc#omnifunc

  set csprg=~/.local/bin/hscope
  set csto=1 " search codex tags first
  set cst
  set csverb

  " nnoremap <buffer> <silent> <C-]> :cs find c <C-R>=expand("<cword>")<CR><CR>

  set completeopt+=longest

  " Show types in completion suggestions
  let b:necoghc_enable_detailed_browse = 1
  " Resolve ghcmod base directory
  au FileType haskell let b:ghcmod_use_basedir = getcwd()

  " Type of expression under cursor
  nmap <buffer> <silent> <leader>ht :GhcModType<CR>
  " Insert type of expression under cursor
  nmap <buffer> <silent> <leader>hT :w<CR>:GhcModTypeInsert<CR>
  " GHC errors and warnings
  nmap <buffer> <silent> <leader>hc :SyntasticCheck hdevtools<CR>

  " Haskell Lint
  let b:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['haskell'] }
  nmap <buffer> <silent> <leader>hl :SyntasticCheck hlint<CR>

  " Options for Haskell Syntax Check
  let b:syntastic_haskell_hdevtools_args = '-g-Wall'

  " Hoogle the word under the cursor
  nnoremap <buffer> <silent> <leader>hh :Hoogle<CR><CR>

  " Hoogle and prompt for input
  nnoremap <buffer> <leader>hH :Hoogle 

  " Hoogle for detailed documentation (e.g. "Functor")
  nnoremap <buffer> <silent> <leader>hi :HoogleInfo<CR><CR>

  " Hoogle for detailed documentation and prompt for input
  nnoremap <buffer> <leader>hI :HoogleInfo 

  " Hoogle, close the Hoogle window
  nnoremap <buffer> <silent> <leader>hz :HoogleClose<CR><CR>

  " }}}

  " Conversion {{{

  "function! Pointfree()
  "  call setline('.', split(system('pointfree '.shellescape(join(getline(a:firstline, a:lastline), "\n"))), "\n"))
  "endfunction
  "vnoremap <buffer> <silent> <leader>h. :call Pointfree()<CR>
  "
  "function! Pointful()
  "  call setline('.', split(system('pointful '.shellescape(join(getline(a:firstline, a:lastline), "\n"))), "\n"))
  "endfunction
  "vnoremap <buffer> <silent> <leader>h> :call Pointful()<CR>

  " }}}
  "

  " let b:syntastic_enable_highlighting = 0
  " SyntasticCheck

  " function! ToggleErrors()
  "     if b:syntastic_enable_highlighting
  "         let b:syntastic_enable_highlighting = 0
  "         " set conceallevel=2
  "         lclose
  "         SyntasticCheck
  "     else
  "         let b:syntastic_enable_highlighting = 1
  "         " set conceallevel=0
  "         SyntasticCheck
  "         Errors
  "     endif
  " endfunction
  " nnoremap <F6> :call ToggleErrors()<cr>

endfunction
au BufRead,BufNewFile /*.hs call LoadHaskell()

