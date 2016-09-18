if has('unix')
    language messages C
else
    language messages en
endif
"NeoBundle Scripts-----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Required:
call neobundle#end()

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
autocmd VimEnter * NeoBundleCheck
" NeoBundleCheck
runtime! settings/*.vim
runtime! settings/settings.d/*.vim
runtime! settings/plugins.d/*.vim
"
" Required:
filetype on
filetype plugin on
filetype indent on

if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  " Hack to get C-h working in neovim
  nmap <BS> <C-h>
  tnoremap <Esc> <C-\><C-n>
endif

