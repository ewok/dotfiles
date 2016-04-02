call neobundle#append()
NeoBundle "vimwiki/vimwiki"
call neobundle#end()

let g:vimwiki_camel_case = 0
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki'}]
"let g:vimwiki_defaults.ext = '.md'

"Generate wiki
nmap <silent> <leader>wg :!python ~/.vim/utils/generate-wiki.py ~/Dropbox/vimwiki/index.md<cr>