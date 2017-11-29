" Other small plugins

Plug 'sheerun/vim-polyglot'
Plug 'Shougo/vimproc.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-emoji'
Plug 'junegunn/vim-peekaboo'
Plug 'tpope/vim-repeat'
Plug 'vitorgalvao/autoswap_mac'
Plug 'tomtom/tlib_vim'
Plug 'itchyny/vim-cursorword'
Plug 'qpkorr/vim-bufkill'
Plug 'dhruvasagar/vim-zoom'
" Plug 'chaoren/vim-wordmotion'

" Fonts
Plug 'powerline/fonts'

" Colorscheme
Plug 'KeitaNakamura/neodark.vim'

" Git time manager
Plug 'git-time-metric/gtm-vim-plugin'

let g:peekaboo_delay = 1000

" vim-zoom
if !hasmapto('<Plug>(zoom-toggle)')
    nnoremap <silent> <Leader>z :call zoom#toggle()<CR>
endif

