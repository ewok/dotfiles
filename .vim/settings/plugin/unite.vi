call neobundle#append()
NeoBundle "Shougo/unite.vim"
NeoBundle "tsukkee/unite-tag"
call neobundle#end()

"Unite
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file_rec/async','sorters','sorter_rank', )
" replacing unite with ctrl-p
let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:unite_prompt='» '
let g:unite_split_rule = 'botright'

if executable('ag')
let g:unite_source_grep_command='ag'
let g:unite_source_grep_default_opts='--nocolor --nogroup -S -C4'
let g:unite_source_grep_recursive_opt=''
endif

nnoremap <silent> <c-p>p :Unite -auto-resize file_rec/async<cr>
nnoremap <silent> <c-p><c-p> :Unite -auto-resize file_rec/async<cr>
nnoremap <silent> <c-p>t :Unite -auto-resize tag<cr>
nnoremap <silent> <c-p><c-t> :Unite -auto-resize tag<cr>
nnoremap <silent> <c-p>b :Unite -auto-resize buffer<cr><esc>
nnoremap <silent> <c-p><c-b> :Unite -auto-resize buffer<cr><esc>
nnoremap <silent> <c-p>y :Unite -no-split -start-insert -auto-resize -buffer-name=Yank_History history/yank<CR>
nnoremap <silent> <c-p><c-y> :Unite -no-split -start-insert -auto-resize -buffer-name=Yank_History history/yank<CR>


" Unit tag
let g:unite_source_tag_max_name_length=40
let g:unite_source_tag_max_kind_length = 8
let g:unite_source_tag_max_fname_length=40
"let g:unite_source_tag_strict_truncate_string=1
"let g:unite_source_tag_relative_fname=0
"let g:unite_source_tag_show_location=0

autocmd FileType unite call s:unite_settings()

function! s:unite_settings()
 let b:SuperTabDisabled=1
 setlocal noswapfile undolevels=-1
 nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction