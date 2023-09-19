;; Treesitter related
(local {: pack} (require :lib))

;; Remove codeblock concealation
(local md-rule "
(atx_heading (inline) @text.title)
(setext_heading (paragraph) @text.title)

[
  (atx_h1_marker)
  (atx_h2_marker)
  (atx_h3_marker)
  (atx_h4_marker)
  (atx_h5_marker)
  (atx_h6_marker)
  (setext_h1_underline)
  (setext_h2_underline)
] @punctuation.special

[
  (link_title)
  (indented_code_block)
  (fenced_code_block)
] @text.literal

(pipe_table_header (pipe_table_cell) @text.title)

(pipe_table_header \"|\" @punctuation.special)
(pipe_table_row \"|\" @punctuation.special)
(pipe_table_delimiter_row \"|\" @punctuation.special)
(pipe_table_delimiter_cell) @punctuation.special

[
  (fenced_code_block_delimiter)
] @punctuation.delimiter

(code_fence_content) @none

[
  (link_destination)
] @text.uri

[
  (link_label)
] @text.reference

[
  (list_marker_plus)
  (list_marker_minus)
  (list_marker_star)
  (list_marker_dot)
  (list_marker_parenthesis)
  (thematic_break)
] @punctuation.special


(task_list_marker_unchecked) @text.todo.unchecked
(task_list_marker_checked) @text.todo.checked

(block_quote) @text.quote

[
  (block_continuation)
  (block_quote_marker)
] @punctuation.special

[
  (backslash_escape)
] @string.escape

(inline) @spell
   ")

(fn config []
  (let [configs (require :nvim-treesitter.configs)
        query (require :vim.treesitter.query)]
    (configs.setup {:ensure_installed [:markdown_inline]
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
                    :context_commentstring {:enable true :enable_autocmd false}})
    (query.set :markdown :highlights md-rule)))

(pack :nvim-treesitter/nvim-treesitter
      {: config :event [:BufReadPre :BufNewFile]})
