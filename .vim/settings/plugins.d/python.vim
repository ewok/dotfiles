" Python support
"
if has('nvim')
    Plug 'zchee/deoplete-jedi', { 'for': 'python', 'do': 'make' }
    autocmd! User deoplete-jedi call LoadPython()
else
    Plug 'https://github.com/davidhalter/jedi-vim.git', { 'for': 'python' }
endif

" let g:jedi#completions_command = "<nop>"
" let g:jedi#auto_vim_configuration = 0
" let g:jedi#completions_enabled = 0
let g:jedi#documentation_command = "K"
let g:jedi#goto_assignments_command = "<leader>jg"
let g:jedi#goto_command = "<c-]>"
let g:jedi#goto_definitions_command = ""
let g:jedi#rename_command = "<leader>jr"
let g:jedi#usages_command = "<leader>ju"

" let b:SuperTabDefaultCompletionType = '<c-space>'

function! LoadPython()
    if exists('g:loaded_python')
        return
    endif
    let g:loaded_python = 1

    map <silent> <buffer> <leader>b oimport pdb; pdb.set_trace()<esc>
    map <silent> <buffer> <leader>B Oimport pdb; pdb.set_trace()<esc>
    let g:jedi#completions_command = "<c-space>"
    set foldmethod=indent
    set foldlevel=0
    set foldnestmax=2
    " set autoindent
    
    let g:neomake_python_pylama_args = ['--format', 'parsable', '--ignore', 'E501']
endfunction

