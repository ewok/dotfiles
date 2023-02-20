(fn config []
  (let [indent (require :indent_blankline)]
    (set vim.g.indent_blankline_buftype_exclude conf.ui-ft)
    (indent.setup {:show_current_context_start false
                   :show_current_context true
                   :show_end_of_line true})))

{: config}
