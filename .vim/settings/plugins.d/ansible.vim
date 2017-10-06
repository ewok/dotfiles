" Ansible support
"
Plug 'pearofducks/ansible-vim', { 'for': 'ansible' }
autocmd! User ansible-vim call LoadAnsible()

function! LoadAnsible()

    let g:neomake_ansible_myansiblelint_maker = {
                \ 'exe': 'ansible-lint',
                \ 'args': ['-p', '--nocolor', '-r', '~/.vim/local/utils/lint'],
                \ 'errorformat': '%f:%l: [ER%n] %m',
                \ }

    let g:neomake_ansible_myyamllint_maker = {
                \ 'exe': 'yamllint',
                \ 'args': "-f parsable -d ~/.vim/local/utils/lint/linter.yaml",
                \ 'errorformat': '%E%f:%l:%c: [error] %m,%W%f:%l:%c: [warning] %m',
                \ }

    let g:neomake_ansible_enabled_makers = ['myansiblelint', 'myyamllint']

endfunction
