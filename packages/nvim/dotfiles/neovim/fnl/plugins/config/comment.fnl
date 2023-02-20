(fn config []
  (let [com (require :Comment)
        valid-filtype [:typescriptreact]
        comment-utils (require :Comment.utils)
        ts-context-commentstring-utils (require :ts_context_commentstring.utils)
        ts-context-commentstring-internal (require :ts_context_commentstring.internal)]
    (com.setup {:opleader {:line :gc :block :gb}
                :toggler {:line :gcc :block :gcb}
                :extra {:above :gck :below :gcj :eol :gcA}
                :pre-hook (fn [ctx]
                            (when (vim.tbl-contains valid-filtype
                                                    vim.bo.filetype)
                              ; Determine whether to use linewise or blockwise commentstring
                              (let [typ (if (= ctx.ctype
                                               comment-utils.ctype.linewise)
                                            :__default
                                            :__multiline)]
                                ; Determine the location where to calculate commentstring from
                                (let [location (if (= ctx.cTSConstructortype
                                                      comment-utils.ctype.blockwise)
                                                   (ts-context-commentstring-utils.get_cursor_location)
                                                   (if (or (= ctx.cmotion
                                                              comment-utils.cmotion.v)
                                                           (= ctx.cmotion
                                                              comment-utils.cmotion.V))
                                                       (ts-context-commentstring-utils.get_visual_start_location)
                                                       nil))]
                                  (ts-context-commentstring-internal.calculate_commentstring {:key typ
                                                                                              : location})))))})))

{: config}
