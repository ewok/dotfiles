if has('unix')
    language messages C
else
    language messages en
endif

runtime! settings/*.vim
runtime! settings/first.d/*.vim

call plug#begin('~/.vim/local/plugged')
runtime! settings/plugins.d/*.vim
runtime! settings/plugins.d/*/*.vim
call plug#end()

runtime! settings/final.d/*.vim

