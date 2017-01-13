" Ansible support
"
call neobundle#append()
NeoBundle "pearofducks/ansible-vim"
" NeoBundle "MicahElliott/Rocannon"
call neobundle#end()

"let g:rocannon_bypass_colorscheme = 1
"
"inoremap <Nul> <C-x><C-o>
function! LoadAnsible()

    if exists('g:loaded_ansible')
        return
    endif
    let g:loaded_ansible = 1

    let g:neomake_ansible_myansiblelint_maker = {
                \ 'exe': 'ansible-lint',
                \ 'args': ['-p', '--nocolor', '-r', '~/.vim/utils/lint'],
                \ 'errorformat': '%f:%l: [ER%n] %m',
                \ }

    let g:neomake_ansible_myyamllint_maker = {
                \ 'exe': 'yamllint',
                \ 'args': "-f parsable -d ~/.vim/utils/lint/linter.yaml",
                \ 'errorformat': '%E%f:%l:%c: [error] %m,%W%f:%l:%c: [warning] %m',
                \ }

    let g:neomake_ansible_enabled_makers = ['myansiblelint', 'myyamllint']
endfunction

au FileType ansible call LoadAnsible()


