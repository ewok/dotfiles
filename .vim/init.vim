" Introduction ------------------------------------------------------------ {{{
" My name is Artur Taranchiev. I love vim and this is my variant of how it
" should be.
" My vim configuration has been totaly reconsidered, at the moment it is the
" one 'uber' configuration file.
" Enjoy reading.
" }}}

" Something... ------------------------------------------------------------ {{{
if has('unix')
    language messages C
else
    language messages en
endif

" }}}
" Basic options ----------------------------------------------------------- {{{
let mapleader = " "

" -> A big mess, should be reviewed {{{
set autoread
set backspace=2
set clipboard+=unnamedplus
set cmdheight=1
set cursorline
set hidden
set history=1000
set laststatus=2
set linebreak
set linespace=0
set mouse=
set nobomb
set nocompatible
set nofoldenable
set nolist
set nostartofline
set nowrap
set number
set numberwidth=4
set ruler
set scrolloff=5
set showmode
set showtabline=2
set splitbelow
set splitright
set switchbuf=useopen
set title
set titlestring=%F
set ttyfast
set undolevels=100
set viminfo='5,\"10,:10,n~/.viminfo
set exrc
set secure

filetype plugin indent on

syntax on
set hlsearch
set incsearch
syntax enable

set nobackup
set noswapfile
set nowritebackup
set copyindent
set ignorecase
set smartcase
set smarttab
set expandtab
set softtabstop=4
set shiftwidth=4
set tabstop=4
set shortmess=aOtT
set confirm

set visualbell
set noerrorbells
set tm=500

set encoding=utf-8
set fenc=utf-8 enc=utf-8 tenc=utf-8
scriptencoding utf-8


" }}}
" -> Wildmenu completion {{{
"
set wildmenu
set wildmode=longest,list

" ignores
set wildignore+=*.o,*.obj,*.pyc
set wildignore+=*.png,*.jpg,*.gif,*.ico
set wildignore+=*.swf,*.fla
set wildignore+=*.mp3,*.mp4,*.avi,*.mkv
set wildignore+=*.git*,*.hg*,*.svn*
set wildignore+=*sass-cache*
set wildignore+=*.DS_Store
set wildignore+=log/**
set wildignore+=tmp/**

" }}}
" -> Cursorline {{{
"
" cursorline switched while focus is switched to another split window

augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

" }}}
" -> Restore cursor {{{

augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" }}}
" -> NeoVim settings  {{{
"
" Settigns for nvim only
"
set inccommand=nosplit

let g:python_host_prog = $HOME . "/share/venv/neovim2/bin/python2"
let g:python3_host_prog = $HOME . "/share/venv/neovim3/bin/python3"

" let g:python_version = matchstr(system("python --version | cut -f2 -d' '"), '^[0-9]')
" if g:python_version =~ 3
"     let g:python_host_prog = $HOME . "/share/venv/neovim2/bin/python2"
" else
"     let g:python3_host_prog = $HOME . "/share/venv/neovim3/bin/python3"
" endif

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

nmap <BS> <C-h>
tnoremap <Esc> <C-\><C-n>

if (has("termguicolors"))
    set termguicolors
endif

" }}}
" -> Deal with largefiles  {{{
"
" Protect large files from sourcing and other overhead.
" Files become read only

let g:largefile=0

if !exists("my_auto_commands_loaded")
    let my_auto_commands_loaded = 1
    " Large files are > 10M
    " Set options:
    " eventignore+=FileType (no syntax highlighting etc
    " assumes FileType always on)
    " noswapfile (save copy of file)
    " bufhidden=unload (save memory when other file is viewed)
    " buftype=nowrite (file is read-only)
    " undolevels=-1 (no undo possible)
    "
    let g:LargeFile = 1024 * 1024 * 3
    augroup LargeFile
        autocmd BufReadPre *
                    \ let f=expand("<afile>")
                    \ | if getfsize(f) > g:LargeFile
                        \ | if input("Large file detected, turn off features? (y/n) ", "y") == "y"
                            \ | setlocal inccommand=
                            \ | setlocal eventignore+=FileType
                            \ | setlocal noswapfile bufhidden=unload undolevels=-1
                            \ | let b:syntastic_mode="passive"
                            \ | let b:ycm_auto_trigger=0
                            \ | let g:largefile=1
                            \ | endif
                        \ | else
                            \ | setlocal eventignore-=FileType
                            \ | let g:largefile=0
                            \ | endif
        " autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
    augroup END
endif
" }}}
" -> Number Toggle  {{{
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
  else
    set rnu
  endif
endfunc

set rnu

augroup rnu
    au!
    au InsertEnter * :set nornu
    au InsertLeave * :set rnu
augroup END

" }}}

" }}}

" -> Leader Initialisation {{{
" Define prefix dictionary
let g:lmap =  {}
let g:lmap.r = { 'name': 'Run/' }
let g:lmap.w = { 'name': 'Wiki/' }
let g:lmap.b = { 'name': 'Buffer/' }
let g:lmap.f = { 'name': 'Find/' }
let g:lmap.p = { 'name': 'CtrlP/'}
let g:lmap.g = { 'name': 'Git/'}
let g:lmap.o = { 'name': 'Options/'}
let g:lmap.t = { 'name': 'Tags/' }
let g:lmap.s = { 'name': 'Session/' }
let g:lmap.q = { 'name': 'QFix/' }

"  }}}

" Keymaps ----------------------------------------------------------------- {{{
" -> Tabs {{{
map gr gT
nnoremap <C-W>t :tabnew<CR>

"  }}}
" -> Windows {{{

" Tmux?
if exists('$TMUX')
    nnoremap <Plug>(window_split-tmux) :!tmux split-window -v -p 30<CR><CR>
    nmap <silent><C-W>S <Plug>(window_split-tmux)

    nnoremap <Plug>(window_vsplit-tmux) :!tmux split-window -h -p 30<CR><CR>
    nmap <silent><C-W>V <Plug>(window_vsplit-tmux)
endif

" split window resize
if bufwinnr(1)
  map <C-W><C-J> :resize +5<CR>
  map <C-W><C-K> :resize -5<CR>
  map <C-W><C-L> :vertical resize +6<CR>
  map <C-W><C-H> :vertical resize -6<CR>
  map <C-W><BS> :vertical resize -6<CR>
endif

"  }}}
" -> Buffers {{{
" Allow to copy/paste between VIM instances
" "copy the current visual selection to ~/.vbuf
vmap <Plug>(buffer_VYank) :w! ~/.vim/.vbuf<CR>
vmap <leader>by <Plug>(buffer_VYank)

" "copy the current line to the buffer file if no visual selection
nmap <Plug>(buffer_Yank) :.w! ~/.vim/.vbuf<CR>
nmap <leader>by <Plug>(buffer_Yank)

" "paste the contents of the buffer file
nmap <Plug>(buffer_Paste) :r ~/.vim/.vbuf<CR>
nmap <leader>bp <Plug>(buffer_Paste)

" }}}
" -> Folding {{{
" Space to toggle folds.
nnoremap <silent> <leader><leader> za
vnoremap <silent> <leader><leader> zf

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap zO zczO

" Close recursively
nnoremap zC zcV:foldc!<CR>

nnoremap <c-z> mzzMzvzz15<c-e>`z

" }}}
" -> Switch off bad habits {{{
imap  <up>    <Nop>
imap  <down>  <Nop>
imap  <left>  <Nop>
imap  <right> <Nop>

nmap  <up>    <Nop>
nmap  <down>  <Nop>
nmap  <left>  <Nop>
nmap  <right> <Nop>

"  }}}
" -> Some vim tunings {{{
nnoremap Y y$

" Don't yank to default register when changing something
nnoremap c "xc
xnoremap c "xc
"
" Don't cancel visual select when shifting
xnoremap <  <gv
xnoremap >  >gv

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" [S]plit line (sister to [J]oin lines) S is covered by cc.
nnoremap S mzi<CR><ESC>`z

" Don't move cursor when searching via *
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap H 0
nnoremap L $

"  }}}

" }}}
" Filetypes --------------------------------------------------------------- {{{
" -> Ansible/Yaml {{{
augroup ft_ansible
    au!
    au BufNewFile,BufRead *.yaml,*.yml set filetype=ansible
    au FileType ansible   setlocal commentstring=#\ %s
augroup END
"  }}}
" -> Config {{{
augroup ft_config
    au!
    au BufNewFile,BufRead *.conf,*.cfg,*.ini set filetype=config
    au FileType config  setlocal commentstring=#\ %s
augroup END
"  }}}
" -> GitIgnore {{{
augroup ft_git
    au!
    au BufNewFile,BufRead *.gitignore set filetype=gitignore
augroup END
"  }}}
" -> JSON {{{
augroup ft_json
    au!
    au BufNewFile,BufRead *.json set filetype=javascript
augroup END
"  }}}
" -> Haskell {{{
augroup ft_haskell
    au!
    au BufNewFile,BufRead *.hs,*.lhs set filetype=haskell
augroup END
"  }}}
" -> Logstash {{{
augroup ft_logstash
    au!
    au FileType logstash setlocal foldmethod=marker|setlocal foldmarker={,}|setlocal wrap
augroup END
"  }}}
" -> Morph {{{
augroup ft_morph
    au!
    au BufNewFile,BufRead *.b64,*.base64 set filetype=base64
    au BufNewFile,BufRead *.enc,*.gpg set filetype=encrypted
augroup END
"  }}}
" -> Python {{{
augroup ft_python
    au!
    au FileType python  setlocal commentstring=#\ %s
    au FileType python map <buffer> <leader>rr :w\|!python % <CR>

    nmap <Plug>(python_breakpoint) oimport pudb; pudb.set_trace()<esc>
    au FileType python map <silent> <buffer> <leader>rb <Plug>(python_breakpoint)
augroup END
"  }}}
" -> Puppet {{{
augroup ft_puppet
    au!
    au FileType puppet  setlocal commentstring=#\ %s
augroup END
"  }}}
" -> Vim {{{
augroup ft_vim
    au!

    au FileType vim setlocal foldmethod=marker keywordprg=:help
    au FileType help setlocal textwidth=78
    au FileType vim  setlocal commentstring=\"\ %s
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif

    au FileType vim inoremap <c-n> <c-x><c-n>
    au FileType vim vnoremap <leader>rS y:@"<CR>
    au FileType vim nnoremap <leader>rS ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

augroup END

" }}}
" -> ZSH {{{
augroup ft_zsh
    au!
    au BufNewFile,BufRead *.zsh-theme set filetype=zsh
augroup END
"  }}}

" }}}
" Plugins ----------------------------------------------------------------- {{{
"
call plug#begin('~/.vim/local/plugged')

" Small plugins {{{
"
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
Plug 'chaoren/vim-wordmotion'

" Fonts
Plug 'powerline/fonts'

" Colorscheme
Plug 'KeitaNakamura/neodark.vim'

" Git time manager
" Plug 'git-time-metric/gtm-vim-plugin'

let g:peekaboo_delay = 1000

" }}}
" Filetype plugins {{{
" -> Ansible {{{
Plug 'pearofducks/ansible-vim', { 'for': 'ansible' }

autocmd! User ansible-vim call LoadAnsible()

function! LoadAnsible() " {{{
    let g:ale_ansible_yamllint_options = '-d ~/.vim/ansible_lint/linter.yaml'
    let g:ale_linters = {'ansible': ['ansible-custom', 'yamllint']}
endfunction " }}}

" }}}
" -> CSV {{{
Plug 'chrisbra/csv.vim', { 'for': 'csv' }
" }}}
" -> Dlang {{{
Plug 'idanarye/vim-dutyl', { 'for': 'd'  }
autocmd! User vim-dutyl call Load_dutyl()

function! Load_dutyl() " {{{
    let g:dutyl_stdImportPaths=['/Library/D/dmd/src/druntime/import','/Library/D/dmd/src/phobos']
endfunction " }}}

" }}}
" -> Go {{{
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
autocmd! User vim-go call LoadGo()

" Plug 'benmills/vimux-golang', { 'for': 'go' }
Plug 'zchee/deoplete-go', { 'do': 'make', 'for': 'go' }
" Plug 'jodosha/vim-godebug', { 'for': 'go' }

function! LoadGo() " {{{

    let $GOPATH = $HOME . '/share/gopath/default'
    " TODO: Make it getting from .gopath
    ". fnamemodify(getcwd(), ':t')
    let $GOBIN = $HOME . '/.local/bin'
    let $PATH = $PATH . ':' . $GOBIN

    " let g:go_highlight_functions = 1
    " let g:go_highlight_methods = 1
    " let g:go_highlight_structs = 1
    " let g:go_highlight_interfaces = 1
    " let g:go_highlight_operators = 1
    " let g:go_highlight_build_constraints = 1

    " let g:go_auto_type_info = 1
    let g:go_auto_sameids = 1
    " let g:go_fmt_autosave = 0
    " let g:go_fmt_command = "goimports"

    " Shortcuts
    nmap <Plug>(go_Run) :silent GoRun<CR>
    nmap <Plug>(go_Test) :GoTest<CR>
    nmap <Plug>(go_Build) :GoBuild<CR>
    nmap <Plug>(go_Coverage-Toggle) :GoCoverageToggle<CR>

    au FileType go map <buffer> <silent> <leader>rr <Plug>(go_Run)
    au FileType go map <buffer> <silent> <leader>rt <Plug>(go_Test)
    au FileType go map <buffer> <silent> <leader>rb <Plug>(go_Build)
    au FileType go map <buffer> <silent> <leader>rc <Plug>(go_Coverage-Toggle)

    let g:lmap.r.d = { 'name': 'Definition' }
    au FileType go nmap <buffer> <Leader>rds <Plug>(go-def-split)
    au FileType go nmap <buffer> <Leader>rdv <Plug>(go-def-vertical)
    au FileType go nmap <buffer> <Leader>rdt <Plug>(go-def-tab)
    " au FileType go nmap <buffer> K <Plug>(go-doc)
    au FileType go nmap <buffer> <Leader>rdi <Plug>(go-info)

endfunction " }}}

" }}}
" -> Logstash {{{
Plug 'robbles/logstash.vim'
"  }}}
" -> Markdown {{{
Plug 'godlygeek/tabular', { 'for': 'markdown' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'shime/vim-livedown', { 'for': 'markdown', 'do': ':!npm install -g livedown' }

let g:vim_markdown_folding_disabled = 1
let g:livedown_browser = 'Safari'
" let g:livedown_autorun = 1
let g:livedown_port = 14545
" }}}
" -> Org mode {{{
Plug 'tpope/vim-speeddating', { 'for': ['org','orgtodo', 'orgagenda'] }
Plug 'jceb/vim-orgmode', { 'for': ['org','orgtodo', 'orgagenda'] }
" }}}
" -> Puppet {{{
Plug 'rodjek/vim-puppet', { 'for': 'puppet' }

" Prevent puppet plugin change alligment
let g:puppet_align_hashes = 0
" }}}
" -> Python {{{
Plug 'zchee/deoplete-jedi', { 'for': 'python', 'do': ':UpdateRemotePlugins' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'fisadev/vim-isort', { 'for': 'python' }
autocmd! User deoplete-jedi call LoadPython()
" autocmd! FileType python call LoadPython()

function! LoadPython() " {{{

    " Be extra sure that jedi works
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#completions_enabled = 0
    let g:jedi#popup_on_dot = 0
    let g:jedi#popup_select_first = 0
    let g:jedi#show_call_signatures = 0
    let g:jedi#smart_auto_mappings = 0

    " let g:jedi#completions_command = "<leader><tab>"
    let g:jedi#documentation_command = "K"
    let g:jedi#goto_assignments_command = "<leader>jgc"
    let g:jedi#goto_command = "<c-]>"
    let g:jedi#goto_definitions_command = "<leader>jgd"
    let g:jedi#rename_command = "<leader>jr"
    let g:jedi#usages_command = "<leader>ju"

    if !exists('g:deoplete#sources')
        let g:deoplete#sources = {}
    endif
    if !exists('g:deoplete#keyword_patterns')
        let g:deoplete#keyword_patterns = {}
    endif
    if !exists('g:deoplete#omni#input_patterns')
        let g:deoplete#omni#input_patterns = {}
    endif

    let g:deoplete#sources#jedi#show_docstring = 1
    let g:deoplete#sources.python = ['buffer', 'member', 'file', 'omni']
    let g:deoplete#omni#input_patterns.python = '([^. \t]\.|^\s*@|^\s*from\s.+ import |^\s*from |^\s*import )\w*'

    set foldmethod=indent
    set foldlevel=0
    set foldnestmax=2

    " let g:neomake_python_pylama_args = ['--format', 'parsable', '--ignore', 'E501']
    let g:ale_python_flake8_executable = 'flake8'
    let g:ale_python_flake8_options = '--ignore E501'
    let g:ale_python_flake8_use_global = 0
    let g:ale_python_mypy_executable = 'mypy'
    let g:ale_python_mypy_options = ''
    let g:ale_python_mypy_use_global = 0
    let g:ale_python_pylint_executable = 'pylint'
    let g:ale_python_pylint_options = '--disable C0301,C0111,C0103'
    let g:ale_python_pylint_use_global = 0

endfunction " }}}

" }}}
" -> Salt {{{
Plug 'saltstack/salt-vim', { 'for': 'sls' }
" }}}
" -> SQL {{{
Plug 'martingms/vipsql', { 'for': 'sql' }
" }}}
" -> VIM {{{
Plug 'Shougo/neco-vim', { 'for': 'vim' }
autocmd! User neco-vim call LoadNeco()

function! LoadNeco() " {{{
    augroup ft_vim
        au!
        au FileType vim nmap <buffer> <leader>rr :source %<CR>:echon "script reloaded!"<CR>
    augroup END
endfunction " }}}

" }}}
" -> XML {{{
Plug 'sukima/xmledit', { 'do': 'make', 'for': ['xml', 'html'] }

" }}}
" -> NodeJSX {{{
Plug 'ternjs/tern_for_vim'
Plug 'mxw/vim-jsx'
" , { 'for': 'javascript.jsx' }
Plug 'mattn/emmet-vim'
" , { 'for': 'javascript.jsx' }
"  }}}
" }}}
" Info plugins {{{
" -> Dash {{{
Plug 'rizzatti/dash.vim'

nnoremap <F1> :set isk+=.<CR>:Dash <cword><CR>:set isk-=.<CR>
inoremap <F1> <ESC>:set isk+=.<CR>:Dash <cword><CR>:set isk-=.<CR>a
" }}}
" }}}
" Motion plugins {{{
" -> Easymotion {{{
Plug 'easymotion/vim-easymotion'

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
nmap ss <Plug>(easymotion-overwin-f)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" Gif config
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" Gif config
map sl <Plug>(easymotion-lineforward)
map sj <Plug>(easymotion-j)
map sk <Plug>(easymotion-k)
map sh <Plug>(easymotion-linebackward)
" }}}
" -> FML {{{
Plug 'ktonga/vim-follow-my-lead'

let g:lmap.f.m = { 'name': "My/" }

let g:fml_all_sources = 1
" }}}
" -> Hardtime {{{
Plug 'takac/vim-hardtime'

let g:hardtime_ignore_quickfix = 1
let g:hardtime_ignore_buffer_patterns = [ "NERD.*", "magit*", "index", "__Tagbar__*", "FAR*" ]
let g:hardtime_default_on = 1
let g:hardtime_timeout = 500
let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+"]
let g:list_of_visual_keys = ["h", "j", "k", "l", "-", "+"]
let g:list_of_insert_keys = []
let g:list_of_disabled_keys = []
let g:hardtime_allow_different_key = 1
let g:hardtime_maxcount = 2
" }}}
" -> Leaderguide {{{
Plug 'hecal3/vim-leader-guide'

function! s:my_displayfunc()
        let g:leaderGuide#displayname =
        \ substitute(g:leaderGuide#displayname, '\c<cr>$', '', '')
        let g:leaderGuide#displayname =
        \ substitute(g:leaderGuide#displayname, '^<Plug>(.*_\(.*\))', '\1', '')
        let g:leaderGuide#displayname =
        \ substitute(g:leaderGuide#displayname, '[-_]', ' ', '')
        let g:leaderGuide#displayname =
        \ substitute(g:leaderGuide#displayname, '[:]', '', '')
endfunction
let g:leaderGuide_displayfunc = [function("s:my_displayfunc")]

nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>

" }}}
" }}}
" }}}
" Text plugins {{{
" -> Drag blocks {{{
Plug 'zirrostig/vim-schlepp'

vmap <unique> <up>    <Plug>SchleppUp
vmap <unique> <down>  <Plug>SchleppDown
vmap <unique> <left>  <Plug>SchleppLeft
vmap <unique> <right> <Plug>SchleppRight
" }}}
" -> Easyalign {{{
Plug 'junegunn/vim-easy-align'

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
" }}}
" -> Find and Replace {{{
Plug 'brooth/far.vim'

let g:far#source = 'agnvim'
let g:far#file_mask_favorites = ['%', '.*', '\.py$', '\.go$']

nnoremap <leader>fr :Far<space>
vnoremap <leader>fr :Far<space>

" }}}
" -> Morph {{{
Plug 'd0c-s4vage/vim-morph', { 'on': 'Morph' }
" , { 'for': [ 'base64', 'encrypted']}

augroup ft_morph
    au!
    au FileType base64,encrypted :Morph
augroup END

command! Morph call Morph()

function! Morph()
    if exists('b:morphed')
        return
    endif
    let b:morphed = 1
    edit
endfunction

" }}}
" -> Mundo {{{
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }

nmap <Plug>(undo_Undo) :MundoToggle<CR><CR>
nmap <silent> <leader>u <Plug>(undo_Undo)
"
if has('persistent_undo')
  silent !mkdir ~/.vim/local/backups > /dev/null 2>&1
  set undodir=~/.vim/local/backups
  set undofile
endif
" }}}
" -> Surround {{{
Plug 'tpope/vim-surround'

let g:surround_113="#{\r}"     " v
let g:surround_35="#{\r}"      " #
let g:surround_45="<% \r %>"   " -
let g:surround_61="<%= \r %>"  " =

" div
let g:surround_{char2nr("d")} = "<div\1id: \r..*\r id=\"&\"\1>\r</div>"
" xml
let g:surround_{char2nr("x")} = "<\1id: \r..*\r&\1>\r</\1\1>"
" }}}
" -> Texting {{{
Plug 'https://github.com/junegunn/goyo.vim'
Plug 'https://github.com/junegunn/limelight.vim'

" Spell Check
let g:myLangList=["nospell","en_us", "ru_ru"]
" let g:myLangListGr=["nospell","en-US","ru-RU"]
function! ToggleSpell()
  if !exists( "b:myLang" )
    if &spell
      let b:myLang=index(g:myLangList, &spelllang)
    else
      let b:myLang=0
    endif
  endif
  let b:myLang=b:myLang+1
  if b:myLang>=len(g:myLangList) | let b:myLang=0 | endif
  if b:myLang==0
    setlocal nospell
    " exe "GrammarousReset"
  else
    execute "setlocal spell spelllang=".get(g:myLangList, b:myLang)
    " execute "GrammarousCheck"
  endif
  echo "spell checking language:" g:myLangList[b:myLang]
endfunction

nmap <silent> <F7> :call ToggleSpell()<CR>
imap <silent> <F7> <ESC>:call ToggleSpell()<CR>a

" Focus on the process
"
function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
  set wrap
  Limelight
  HardTimeOff
  " ...
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  set nowrap
  Limelight!
  HardTimeOn
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

map <silent> <F8> :Goyo<CR>
" }}}
" -> Xkb {{{
Plug 'lyokha/vim-xkbswitch'

" git clone https://github.com/vovkasm/input-source-switcher.git
" cd input-source-switcher
" mkdir build && cd build
" cmake ..
" make
" make install
"
let g:XkbSwitchLib = '/usr/local/lib/libInputSourceSwitcher.dylib'

let g:XkbSwitchEnabled = 1
let g:XkbSwitchSkipFt = [ 'nerdtree' ]

" }}}
" -> Yank {{{
Plug 'idanarye/vim-yankitute'

nmap <expr>  MR  ':%s/\(' . @/ . '\)//g<LEFT><LEFT>'
nmap <expr>  MY  ':%Yankitute/\(' . @/ . '\)/\1/g<LEFT><LEFT>'
vmap <expr>  MR  ':s/\(' . @/ . '\)//g<LEFT><LEFT>'
vmap <expr>  MY  ':Yankitute/\(' . @/ . '\)/\1/g<LEFT><LEFT>'
" }}}
" -> VimWiki {{{
"
Plug 'vimwiki/vimwiki'

autocmd! VimEnter * call LoadVimwiki()

function! LoadVimwiki()
    map <Leader>w<CR> <Plug>VimwikiToggleListItem
    nunmap <Leader>ww
    map <Leader>ww :call VimwikiIndexCd()<CR>
endfunction

function! VimwikiIndexCd()
    VimwikiIndex
    cd %:h
endfunction

let g:vimwiki_list = [{'path': '~/Disk/Notes/',
                    \ 'syntax': 'markdown', 'ext': '.md',
                    \ 'auto_toc': 1,
                    \ 'list_margin': 0,'auto_tags': 1}]


" }}}
" }}}
" UI plugins {{{
" -> Buffers {{{
Plug 'jeetsukumaran/vim-buffergator', { 'on': 'BuffergatorToggle' }

let g:buffergator_suppress_keymaps=1
let g:buffergator_viewport_split_policy="B"

nnoremap <silent> <F4> :BuffergatorToggle<CR>
nnoremap <silent> <leader>bb :BuffergatorToggle<CR>
" }}}
" -> Fuzzy {{{
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

let g:fzf_tags_command = 'ctags -R --exclude=.git --exclude=.idea --exclude=log'

nnoremap <silent> <leader>pt :Tags<cr>
nnoremap <silent> <leader>pp :Files<cr>
nnoremap <silent> <leader>pm :Marks<cr>
nnoremap <silent> <leader>pb :Buffers<cr>
nnoremap <silent> <leader>pf :Filetypes<cr>

nnoremap <Plug>(git_Files) :GFiles?<cr>
nnoremap <Plug>(git_History) :Commits<cr>
nnoremap <Plug>(git_File-History) :BCommits<cr>

nmap <silent> <leader>gf <Plug>(git_Files)
nmap <silent> <leader>gh  <Plug>(git_History)
nmap <silent> <leader>gbc <Plug>(git_File-History)


command! -bang FT call fzf#vim#filetypes(<bang>0)
nnoremap <Plug>(options_File-Type) :FT<CR>
nmap <silent> <leader>ot <Plug>(options_File-Type)

nnoremap <Plug>(find_String) :Ag<CR>
nmap <silent> <leader>ff <Plug>(find_String)

nnoremap <silent> <c-p><c-p> <nop>
nnoremap <silent> <c-p><c-t> <nop>
nnoremap <silent> <c-p><c-b> <nop>

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
" }}}
" -> Indent-guides {{{
Plug 'nathanaelkane/vim-indent-guides'

let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=237
hi IndentGuidesEven ctermbg=236

let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_default_mapping = 0

if g:largefile != 1
    autocmd VimEnter * :IndentGuidesEnable
endif
" }}}
" -> Lightline {{{
Plug 'itchyny/lightline.vim'
autocmd! User lightline call LoadLight()

function LoadLight()
    if !has('gui_running')
        set t_Co=256
    endif

endfunction
" }}}
" -> Dirvish {{{
Plug 'justinmk/vim-dirvish'
Plug 'kristijanhusak/vim-dirvish-git'
Plug 'bounceme/remote-viewer'

augroup dirvish_config
	autocmd!
	autocmd FileType dirvish silent! unmap <buffer> q
	autocmd FileType dirvish silent! map <buffer> q :bd<CR>
augroup END
let g:dirvish_mode = ':sort ,^.*[\/],'

nnoremap <leader>fp :Ldirvish %<CR>
nnoremap <silent> <F2> :Ldirvish<CR>

command! -nargs=? -complete=dir Ldirvish leftabove 25vsplit | silent Dirvish <args>
" }}}
" -> Tmux {{{
if has('gui_running')
else
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'benmills/vimux'

    nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

    let g:tmux_navigator_save_on_switch = 2
    let g:tmux_navigator_disable_when_zoomed = 1

    let g:VimuxHeight = "15"
endif
" }}}
" }}}
" Code plugins {{{
" -> Commentary {{{
Plug 'https://github.com/tpope/vim-commentary.git'

set commentstring=#\ %s
" }}}
" -> Autocompletion {{{
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

" }}}
" -> Ctags {{{
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
"
Plug 'jsfaint/gen_tags.vim'

autocmd! User tagbar call LoadTagBar()

nnoremap <leader>tt :TagbarToggle<CR>
nnoremap <F3> :TagbarToggle<CR>

nnoremap <Plug>(tags_Update) :!ctags -R --exclude=.git --exclude=.idea --exclude=log<CR><CR>
nmap <leader>tu <Plug>(tags_Update)

set tags=tags;/,codex.tags;/

function! LoadTagBar()

	let g:tagbar_type_puppet = {
				\ 'ctagstype': 'puppet',
				\ 'kinds': [
				\'c:class',
				\'s:site',
				\'n:node',
				\'d:definition',
				\'r:resource',
				\'f:default'
				\]
				\}

	let g:tagbar_type_haskell = {
				\ 'ctagsbin'  : 'hasktags',
				\ 'ctagsargs' : '-x -c -o-',
				\ 'kinds'     : [
				\  'm:modules:0:1',
				\  'd:data: 0:1',
				\  'd_gadt: data gadt:0:1',
				\  't:type names:0:1',
				\  'nt:new types:0:1',
				\  'c:classes:0:1',
				\  'cons:constructors:1:1',
				\  'c_gadt:constructor gadt:1:1',
				\  'c_a:constructor accessors:1:1',
				\  'ft:function types:1:1',
				\  'fi:function implementations:0:1',
				\  'o:others:0:1'
				\ ],
				\ 'sro'        : '.',
				\ 'kind2scope' : {
				\ 'm' : 'module',
				\ 'c' : 'class',
				\ 'd' : 'data',
				\ 't' : 'type'
				\ },
				\ 'scope2kind' : {
				\ 'module' : 'm',
				\ 'class'  : 'c',
				\ 'data'   : 'd',
				\ 'type'   : 't'
				\ }
				\ }

	let g:tagbar_type_go = {
				\ 'ctagstype' : 'go',
				\ 'kinds'     : [
				\ 'p:package',
				\ 'i:imports:1',
				\ 'c:constants',
				\ 'v:variables',
				\ 't:types',
				\ 'n:interfaces',
				\ 'w:fields',
				\ 'e:embedded',
				\ 'm:methods',
				\ 'r:constructor',
				\ 'f:functions'
				\ ],
				\ 'sro' : '.',
				\ 'kind2scope' : {
				\ 't' : 'ctype',
				\ 'n' : 'ntype'
				\ },
				\ 'scope2kind' : {
				\ 'ctype' : 't',
				\ 'ntype' : 'n'
				\ },
				\ 'ctagsbin'  : 'gotags',
				\ 'ctagsargs' : '-sort -silent'
				\ }

	let g:tagbar_type_ansible = {
				\ 'ctagstype' : 'ansible',
				\ 'kinds' : [
				\ 't:tasks'
				\ ],
				\ 'sort' : 0
				\ }

endfunction
" }}}
" -> TODO: Check actuality Folding  {{{
Plug 'pseewald/vim-anyfold'

if g:largefile != 1
    autocmd Filetype python,ansible,puppet,go,xml,json,sh,zsh let b:anyfold_activate=1
endif

" }}}
" -> Git {{{
"  -> Leader Git menu {{{
let g:lmap.g.b = { 'name': 'Blame/' }
let g:lmap.g.p = { 'name': 'Push&Pull/' }
let g:lmap.g.p.l = { 'name': 'Pull/' }
"  }}}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
Plug 'jreybert/vimagit'

" Fugitive options
"
" shortcuts mapping
nnoremap <Plug>(git_Status) :Gstatus<CR>
nnoremap <Plug>(git_Diff) :Gdiff<CR>
nnoremap <Plug>(git_Commit) :Gcommit<CR>
nnoremap <Plug>(git_Push) :silent Git push<CR>
nnoremap <Plug>(git_Write) :Gwrite<CR>
nnoremap <Plug>(git_Blame) :Gblame<CR>
nnoremap <Plug>(git_Read) :Gread<CR>
nnoremap <Plug>(git_Rebase) :silent Git pull --rebase<CR>
nnoremap <Plug>(git_Merge) :silent Git pull<CR>
nnoremap <Plug>(git_Browse) :.Gbrowse %<CR>
vnoremap <Plug>(git_VBrowse) :'<,'>Gbrowse %<CR>

nmap <silent> <leader>gS <Plug>(git_Status)
nmap <silent> <leader>gd <Plug>(git_Diff)
nmap <silent> <leader>gC <Plug>(git_Commit)
nmap <silent> <leader>gps <Plug>(git_Push)
nmap <silent> <leader>gW <Plug>(git_Write)
nmap <silent> <leader>gbl <Plug>(git_Blame)
nmap <silent> <leader>gR <Plug>(git_Read)
nmap <silent> <leader>gplr <Plug>(git_Rebase)
nmap <silent> <leader>gplm <Plug>(git_Merge)
nmap <silent> <leader>gg <Plug>(git_Browse)
vmap <silent> <leader>gg <Plug>(git_VBrowse)

" Magit option
nmap <silent> <leader>gs <Plug>(git_Magit)
let g:magit_show_magit_mapping='<Plug>(git_Magit)'

" Gitgutter options
let g:gitgutter_map_keys = 0

nmap [c <Plug>GitGutterPrevHunk
nmap ]c <Plug>GitGutterNextHunk

let g:gitgutter_override_sign_column_highlight = 0

" Gitv options
let g:Gitv_DoNotMapCtrlKey = 1
nnoremap <Plug>(git_Full-History) :GV<CR>
nmap <silent> <leader>gH <Plug>(git_Full-History)
" }}}
" -> Linter {{{
Plug 'w0rp/ale'

" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>'
let g:ale_sign_warning = '-'

" }}}
" -> Snippet {{{
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'kiith-sa/DSnips'

let g:ulti_expand_or_jump_res = 0

function! <SID>ExpandSnippetOrReturn()
  let snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return snippet
  else
    return "\<CR>"
  endif
endfunction

inoremap <expr> <CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "\<CR>"
" }}}
" }}}

call plug#end()

" }}}
" Simple plugins ---------------------------------------------------------- {{{

" -> Sessions {{{
let g:sessiondir = $HOME . "/.vim/local/sessions"

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

nnoremap <Plug>(session_Load) :LoadSession<SPACE>
nnoremap <Plug>(session_Load-Current) :LoadSessionCurrent<CR>
nnoremap <Plug>(session_Make) :MakeSessionCurrent<CR>
nnoremap <Plug>(session_Exit) :CloseSessionAndExit<CR>
nnoremap <Plug>(session_Close) :CloseSession<CR>
nnoremap <Plug>(session_Delete) :DeleteSessionCurrent<CR>

nmap <leader>so <Plug>(session_Load)
nmap <leader>su <Plug>(session_Load-Current)
nmap <leader>ss <Plug>(session_Make)
nmap <leader>sq <Plug>(session_Exit)
nmap <leader>sx <Plug>(session_Close)
nmap <leader>sd <Plug>(session_Delete)
" }}}
" -> Folding {{{
" Thx Steve Losh
set foldlevelstart=0

" "Focus" the current line.  Basically:
"
" 1. Close all folds.
" 2. Open just the folds containing the current line.
" 3. Move the line to a little bit (15 lines) above the center of the screen.
"
" This mapping wipes out the z mark, which I never use.
"
function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" }}}
" -> AutoSave feature {{{
"
" Trigger autoread when changing buffers or coming back to vim.
au FocusGained,BufEnter,WinEnter * :silent! !

au! FileType vim,python,golang,go,ansible,puppet,json,sh,vimwiki call DefaultOn()

function! DefaultOn()
        if !exists("b:auto_save")
            let b:auto_save = 1
        endif
endfunction

set updatetime=4000

let s:save_cpo = &cpo
set cpo&vim

if !exists("g:auto_save_silent")
  let g:auto_save_silent = 0
endif

if !exists("g:auto_save_events")
  let g:auto_save_events = ["CursorHold","BufLeave","FocusLost","WinLeave"]
  " let g:auto_save_events = ["InsertLeave", "TextChanged", "CursorHold"]
endif

" Check all used events exist
for event in g:auto_save_events
  if !exists("##" . event)
    let eventIndex = index(g:auto_save_events, event)
    if (eventIndex >= 0)
      call remove(g:auto_save_events, eventIndex)
      echo "(AutoSave) Save on " . event . " event is not supported for your Vim version!"
      echo "(AutoSave) " . event . " was removed from g:auto_save_events variable."
      echo "(AutoSave) Please, upgrade your Vim to a newer version or use other events in g:auto_save_events!"
    endif
  endif
endfor

augroup auto_save
  autocmd!
  for event in g:auto_save_events
    execute "au " . event . " * nested call AutoSave()"
  endfor
augroup END

function! AutoSave()
    if &modified > 0
        if !exists("b:auto_save")
            let b:auto_save = 0
        endif

        if b:auto_save == 0
            return
        end


        let was_modified = &modified

        " Preserve marks that are used to remember start and
        " end position of the last changed or yanked text (`:h '[`).
        let first_char_pos = getpos("'[")
        let last_char_pos = getpos("']")

        call DoSave()

        call setpos("'[", first_char_pos)
        call setpos("']", last_char_pos)

        if was_modified && !&modified
            if g:auto_save_silent == 0
                echo "(AutoSave) saved at " . strftime("%H:%M:%S")
            endif
        endif
    endif
endfunction

function! DoSave()
    silent! w
endfunction

function! ToggleAutoSave()
        if !exists("b:auto_save")
            let b:auto_save = 0
        endif

        if b:auto_save == 0
            let b:auto_save = 1
        else
            let b:auto_save = 0
        end
endfunction

command! ToggleAutoSave :call ToggleAutoSave()

let &cpo = s:save_cpo
unlet s:save_cpo

" }}}
" -> Quickfix {{{
"
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

nnoremap <Plug>(qfix_Toggle) :QFix<CR>
nnoremap <Plug>(qfix_Open) :copen<CR>
nnoremap <Plug>(qfix_Close) :cclose<CR>
nnoremap <Plug>(qfix_LOpen) :lopen<CR>
nnoremap <Plug>(qfix_LClose) :lclose<CR>

nmap <leader>qq  <Plug>(qfix_Toggle)
nmap <leader>qco <Plug>(qfix_Open)
nmap <leader>qcc <Plug>(qfix_Close)
nmap <leader>qlo <Plug>(qfix_LOpen)
nmap <leader>qlc <Plug>(qfix_LClose)

" }}}

" }}}
" Leader Finish
call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
" Colorscheme ------------------------------------------------------------- {{{
let g:neodark#background = '#282c34'

colorscheme neodark

let g:lightline = {}
let g:lightline.colorscheme = 'neodark'

" }}}

