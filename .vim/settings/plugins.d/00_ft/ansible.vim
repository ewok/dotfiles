" Ansible support
"
Plug 'pearofducks/ansible-vim', { 'for': 'ansible' }
autocmd! User ansible-vim call LoadAnsible()

function! LoadAnsible()
    let g:ale_ansible_yamllint_options = '-d ~/.vim/ansible_lint/linter.yaml'
    let g:ale_linters = {'ansible': ['ansible-custom', 'yamllint']}
endfunction
