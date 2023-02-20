(local {: set! : map!} (require :lib))

;; Autoread
(tset vim.opt :autoread true)
(vim.api.nvim_create_autocmd [:BufEnter :CursorHold :CursorHoldI :FocusGained]
                             {:command "if mode() != 'c' | checktime | endif"
                              :pattern ["*"]})

;; Autosize windows
(vim.api.nvim_create_autocmd [:VimResized] {:command "wincmd ="
                             :pattern ["*"]})

;; Converters
(map! "v" "<leader>6d" "c<c-r>=system('base64 --decode', @\")<cr><esc>" { :noremap true :silent true } "Decode Base64")
(map! "v" "<leader>6e" "c<c-r>=system('base64', @\")<cr><esc>" { :noremap true :silent true } "Encode Base64")
