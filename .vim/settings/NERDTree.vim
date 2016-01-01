call neobundle#append()
NeoBundle "scrooloose/nerdtree"
NeoBundle "Xuyuanp/nerdtree-git-plugin"
NeoBundle "jistr/vim-nerdtree-tabs"
call neobundle#end()

"nnoremap <silent> <F2> :NERDTreeTabsToggle<CR>
nnoremap <silent> <F2> :NERDTreeMirrorToggle<CR>
let NERDTreeShowBookmarks=0
let NERDTreeChDirMode=2
let NERDTreeMouseMode=2
let g:nerdtree_tabs_focus_on_files=1
let g:nerdtree_tabs_open_on_gui_startup=0
" open directory of current opened file
map <leader>r :NERDTreeFind<cr>

" make nerdtree look nice
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let g:NERDTreeWinSize=30
let NERDTreeIgnore=['\.pyc$']

 "NERDTree git
silent! if emoji#available()
  let g:NERDTreeIndicatorMapCustom = {
      \     "Modified"  : emoji#for('pencil'),
      \     "Staged"    : emoji#for('+1'),
      \     "Untracked" : emoji#for('feet'),
      \     "Renamed"   : emoji#for('cyclone'),
      \     "Unmerged"  : emoji#for('broken_heart'),
      \     "Deleted"   : emoji#for('skull'),
      \     "Dirty"     : emoji#for('hankey'),
      \     "Clean"     : emoji#for('sunny'),
      \     "Unknown"   : emoji#for('question')
      \}
else
  let g:NERDTreeIndicatorMapCustom = {
      \     "Modified"  : "~",
      \     "Staged"    : "s",
      \     "Untracked" : "+",
      \     "Renamed"   : "r",
      \     "Unmerged"  : "±",
      \     "Deleted"   : "-",
      \     "Dirty"     : "d",
      \     "Clean"     : "c",
      \     "Unknown"   : "u"
      \}
endif