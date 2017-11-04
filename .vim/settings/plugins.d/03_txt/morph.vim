" Morph your text
"
Plug 'd0c-s4vage/vim-morph', { 'on': 'Morph' }
" , { 'for': [ 'base64', 'encrypted']}

au! FileType base64,encrypted :Morph

command! Morph call Morph()

function! Morph()
    if exists('b:morphed')
        return
    endif
    let b:morphed = 1
    edit
endfunction

