" Python support
"
" Plug 'zchee/deoplete-jedi', { 'for': 'python', 'do': 'make' }
" autocmd! User deoplete-jedi call LoadPython()
autocmd! FileType python call LoadPython()

function! LoadPython()

    let g:jedi#completions_command = "<c-space>"
    let g:jedi#documentation_command = "K"
    let g:jedi#goto_assignments_command = "<leader>jg"
    let g:jedi#goto_command = "<c-]>"
    let g:jedi#goto_definitions_command = ""
    let g:jedi#rename_command = "<leader>jr"
    let g:jedi#usages_command = "<leader>ju"

    set foldmethod=indent
    set foldlevel=0
    set foldnestmax=2

    let g:neomake_python_pylama_args = ['--format', 'parsable', '--ignore', 'E501']

    au FileType python map <buffer> <leader>rr :w\|!python % <CR>
    au FileType python map <silent> <buffer> <leader>b oimport pdb; pdb.set_trace()<esc>
    au FileType python map <silent> <buffer> <leader>B Oimport pdb; pdb.set_trace()<esc>

endfunction

