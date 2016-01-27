call neobundle#append()
NeoBundle "https://github.com/davidhalter/jedi-vim.git"
call neobundle#end()

" let g:jedi#completions_command = "<nop>"
" let g:jedi#auto_vim_configuration = 0
" let g:jedi#completions_enabled = 0
let g:jedi#documentation_command = "K"
let g:jedi#goto_assignments_command = "<leader>gog"
let g:jedi#goto_command = "<c-]>"
let g:jedi#goto_definitions_command = ""
let g:jedi#rename_command = "<leader>jr"
let g:jedi#usages_command = "<leader>ju"

" let b:SuperTabDefaultCompletionType = '<c-space>'


function! LoadPython()
    map <silent> <buffer> <leader>b oimport pdb; pdb.set_trace()<esc>
    map <silent> <buffer> <leader>B Oimport pdb; pdb.set_trace()<esc>
    let g:jedi#completions_command = "<c-space>"
    set foldmethod=indent
    set foldlevel=0
    set foldnestmax=2
    " set autoindent
endfunction
au FileType python call LoadPython()
