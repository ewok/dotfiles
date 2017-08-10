if has('unix')
    language messages C
else
    language messages en
endif

runtime! settings/*.vim
runtime! settings/settings.d/*.vim

call plug#begin()
runtime! settings/plugins.d/*.vim
call plug#end()

runtime! settings/final.d/*.vim

" " Required:
" filetype on
" filetype plugin on
" filetype indent on

if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  " Hack to get C-h working in neovim
  nmap <BS> <C-h>
  tnoremap <Esc> <C-\><C-n>
endif

