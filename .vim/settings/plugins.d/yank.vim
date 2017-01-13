" Replace finded template
"
call neobundle#append()
NeoBundle "idanarye/vim-yankitute"
call neobundle#end()

nmap <expr>  MR  ':%s/\(' . @/ . '\)//g<LEFT><LEFT>'
nmap <expr>  MY  ':%Yankitute/\(' . @/ . '\)/\1/g<LEFT><LEFT>'
vmap <expr>  MR  ':s/\(' . @/ . '\)//g<LEFT><LEFT>'
vmap <expr>  MY  ':Yankitute/\(' . @/ . '\)/\1/g<LEFT><LEFT>'
