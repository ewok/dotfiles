call neobundle#append()
NeoBundle "mnpk/vim-jira-complete"
call neobundle#end()

let g:jiracomplete_url = 'https://onefactorlab.atlassian.net'
let g:jiracomplete_username = 'Artur.Taranchiev'
" let g:jiracomplete_password = 'your_jira_password'  " optional"
" imap <silent> <unique> <leader>j <Plug>JiraComplete
