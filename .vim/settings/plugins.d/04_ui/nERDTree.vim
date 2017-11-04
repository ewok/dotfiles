" NERDTree
"
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeMirrorToggle', 'NERDTreeFind'] }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': ['NERDTreeMirrorToggle', 'NERDTreeFind'] }
Plug 'jistr/vim-nerdtree-tabs', { 'on': ['NERDTreeMirrorToggle', 'NERDTreeFind'] }

nnoremap <F2> :NERDTreeMirrorToggle<CR>
nnoremap <leader>fp :NERDTreeFind<CR>

let NERDTreeShowBookmarks=0
let NERDTreeChDirMode=2
let NERDTreeMouseMode=2
let g:nerdtree_tabs_focus_on_files=1
let g:nerdtree_tabs_open_on_gui_startup=0

" make nerdtree look nice
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let g:NERDTreeWinSize=30
let NERDTreeIgnore=['\.pyc$']

" ReMaps
let NERDTreeMapOpenVSplit='v'
let NERDTreeMapOpenSplit='s'
