" call neobundle#append()
" NeoBundle '907th/vim-auto-save'
" call neobundle#end()

" Trigger autoread when changing buffers or coming back to vim.
au FocusGained,BufEnter,WinEnter * :silent! !

au FileType vim,python,golang,go,ansible,puppet,json let b:auto_save = 1

set updatetime=2000

let s:save_cpo = &cpo
set cpo&vim

if !exists("g:auto_save_silent")
  let g:auto_save_silent = 0
endif

if !exists("g:auto_save_events")
  let g:auto_save_events = ["CursorHold","BufLeave","FocusLost","WinLeave"]
  " let g:auto_save_events = ["InsertLeave", "TextChanged", "CursorHold"]
endif

" Check all used events exist
for event in g:auto_save_events
  if !exists("##" . event)
    let eventIndex = index(g:auto_save_events, event)
    if (eventIndex >= 0)
      call remove(g:auto_save_events, eventIndex)
      echo "(AutoSave) Save on " . event . " event is not supported for your Vim version!"
      echo "(AutoSave) " . event . " was removed from g:auto_save_events variable."
      echo "(AutoSave) Please, upgrade your Vim to a newer version or use other events in g:auto_save_events!"
    endif
  endif
endfor

augroup auto_save
  autocmd!
  for event in g:auto_save_events
    execute "au " . event . " * nested call AutoSave()"
  endfor
augroup END

function! AutoSave()
    if &modified > 0
        if !exists("b:auto_save")
            let b:auto_save = 0
        endif

        if b:auto_save == 0
            return
        end


        let was_modified = &modified

        " Preserve marks that are used to remember start and
        " end position of the last changed or yanked text (`:h '[`).
        let first_char_pos = getpos("'[")
        let last_char_pos = getpos("']")

        call DoSave()

        call setpos("'[", first_char_pos)
        call setpos("']", last_char_pos)

        if was_modified && !&modified
            if g:auto_save_silent == 0
                echo "(AutoSave) saved at " . strftime("%H:%M:%S")
            endif
        endif
    endif
endfunction

function! DoSave()
    silent! w
endfunction

function! ToggleAutoSave()
        if !exists("b:auto_save")
            let b:auto_save = 0
        endif

        if b:auto_save == 0
            let b:auto_save = 1
        else
            let b:auto_save = 0
        end
endfunction

command! ToggleAutoSave :call ToggleAutoSave()

let &cpo = s:save_cpo
unlet s:save_cpo

