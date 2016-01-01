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