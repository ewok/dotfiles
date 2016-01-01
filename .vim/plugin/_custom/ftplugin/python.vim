" let b:SuperTabDefaultCompletionType = '<c-space>'
function! LoadPython()
    map <silent> <buffer> <leader>b oimport pdb; pdb.set_trace()<esc>
    map <silent> <buffer> <leader>B Oimport pdb; pdb.set_trace()<esc>
    let g:jedi#completions_command = "<c-space>"
    set foldmethod=indent
    set foldlevel=0
    set foldnestmax=2
endfunction
au FileType python call LoadPython() 