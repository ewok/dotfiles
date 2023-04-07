(local {: path-join} (require :lib))

(vim.fn.setenv :PATH
               (.. (path-join conf.data-dir :mason :bin) ":" vim.env.PATH))

; Dealing with largefiles
; Protect large files from sourcing and other overhead.
(vim.api.nvim_create_augroup :LargeFile {})
(vim.api.nvim_create_autocmd [:BufReadPre]
                             {:pattern "*"
                              :group :LargeFile
                              :callback #(let [fname (vim.fn.expand :<afile>)]
                                           (when (> (vim.fn.getfsize fname)
                                                    conf.options.large_file_size)
                                             (when (= :y
                                                      (vim.fn.input "Large file detected, turn off features?(y): "
                                                                    :y))
                                               (vim.cmd "setlocal inccommand=")
                                               (vim.cmd "setlocal wrap")
                                               (vim.cmd "syntax off")
                                               (vim.cmd :IndentBlanklineDisable)
                                               (set vim.opt_local.foldmethod
                                                    :manual)
                                               (set vim.opt_local.spell false)
                                               (set vim.bo.swapfile false)
                                               (set vim.bo.bufhidden :unload)
                                               (set vim.bo.buftype :nowrite)
                                               (set vim.bo.undolevels -1)
                                               (vim.cmd "setlocal eventignore+=FileType")
                                               (set vim.g.largefile true))))})
