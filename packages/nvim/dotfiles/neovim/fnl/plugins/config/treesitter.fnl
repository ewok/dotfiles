(fn config []
  (let [configs (require :nvim-treesitter.configs)]
    (configs.setup {:ensure_installed {}
                    :ignore_install {}
                    :sync_install false
                    :auto_install true
                    :matchup {:enable false}
                    :highlight {:enable true
                                :additional_vim_regex_highlighting false}
                    :indent {:enable true :disable [:yaml :python :html :vue]}
                    ; -- incremental selection
                    :incremental_selection {:enable false
                                            :keymaps {:init_selection :<cr>
                                                      :node_incremental :<cr>
                                                      :node_decremental :<bs>
                                                      :scope_incremental :<tab>}}
                    ; -- nvim-ts-rainbow
                    :rainbow {:enable conf.options.rainbow_parents
                              :extended_mode true
                              :max_file_lines 1000}
                    ; -- nvim-ts-autotag
                    :autotag {:enable true}
                    ; -- nvim-ts-context-commentstring
                    :context_commentstring {:enable true :enable_autocmd false}})))

{: config}
