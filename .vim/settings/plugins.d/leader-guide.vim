" Leader key hints(awesome plugin!)
"
call neobundle#append()
NeoBundle "hecal3/vim-leader-guide"
call neobundle#end()

" Define prefix dictionary
let g:lmap =  {}

" Second level dictionaries:
let g:lmap.b = { 'name' : 'Buffer' }
let g:lmap.f = { 'name' : 'Find' }
let g:lmap.f.m = { 'name' : ':Follow my' }
let g:lmap.g = { 'name' : 'Git' }
let g:lmap.g.p = { 'name' : ':Push OR :Pull' }
let g:lmap.i = { 'name' : 'Indent' }
" let g:lmap.m = { 'name' : 'Markdown' }
" let g:lmap.m.p = { 'name' : ':Preview' }
let g:lmap.p = { 'name' : 'PopUp' }
let g:lmap.q = { 'name' : 'Quick' }
let g:lmap.r = { 'name' : 'Run' }
let g:lmap.s = { 'name' : 'Session' }
let g:lmap.t = { 'name' : 'Tags' }
let g:lmap.v = { 'name' : 'VBuf' }
let g:lmap.w = { 'name' : 'Window' }


" Create new menus not based on existing mappings:
" let g:lmap.g = {
"                 \'name' : 'Git Menu',
"                 \'s' : ['Gstatus', 'Git Status'],
"                 \'p' : ['Gpull',   'Git Pull'],
"                 \'u' : ['Gpush',   'Git Push'],
"                 \'c' : ['Gcommit', 'Git Commit'],
"                 \'w' : ['Gwrite',  'Git Write'],
"                 \}
"

call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>

