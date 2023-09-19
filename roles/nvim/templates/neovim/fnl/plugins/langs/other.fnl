(local {: pack} (require :lib))

[;; CSV
 (pack :chrisbra/csv.vim {:config false
                          :event [:BufReadPre :BufNewFile]
                          :ft :csv})
 ;; Ansible
 (pack :mfussenegger/nvim-ansible
       {:config false :event [:BufReadPre :BufNewFile]})
 ;; Python
 (pack :Vimjas/vim-python-pep8-indent {:ft :python :event [:InsertEnter]})]
