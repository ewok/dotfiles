(local opts {:modules {:bib false
                       :buffers true
                       :conceal false
                       :cursor true
                       :folds false
                       :links true
                       :lists true
                       :maps true
                       :paths true
                       :tables true
                       :yaml false}
             :filetypes {:md true :rmd true :markdown true}
             :create_dirs true
             :perspective {:priority :first
                           :fallback :current
                           :root_tell false
                           :nvim_wd_heel true}
             :wrap false
             :silent false
             :links {:style :markdown
                     :name_is_source false
                     :conceal true
                     :context 1
                     ;0
                     :implicit_extension nil
                     :transform_implicit false
                     :transform_explicit (fn [text]
                                           (-> text
                                               (str/replace " " "-")
                                               (str/lower-case)
                                               (str/join (str (time/now) "_"))))}
             :to_do {:symbols [" " "+" :x]
                     :update_parents true
                     :not_started " "
                     :in_progress "+"
                     :complete :x}
             :tables {:trim_whitespace true
                      :format_on_move true
                      :auto_extend_rows false
                      :auto_extend_cols false}
             :mappings {:MkdnEnter [[:n :v] :<M-CR>]
                        :MkdnTab false
                        :MkdnSTab false
                        :MkdnNextLink [:n "]l"]
                        :MkdnPrevLink [:n "[l"]
                        :MkdnNextHeading [:n "]]"]
                        :MkdnPrevHeading [:n "[["]
                        :MkdnGoBack [:n :<BS>]
                        :MkdnGoForward [:n :<Del>]
                        :MkdnFollowLink false
                        :MkdnMoveSource [:n :<leader>wr]
                        :MkdnYankAnchorLink [:n :ya]
                        :MkdnYankFileAnchorLink [:n :yfa]
                        :MkdnIncreaseHeading [:n "+"]
                        :MkdnDecreaseHeading [:n "-"]
                        :MkdnToggleToDo [[:n :v] :<C-Space>]
                        :MkdnNewListItem [:i :<CR>]
                        :MkdnNewListItemBelowInsert [:n :o]
                        :MkdnNewListItemAboveInsert [:n :O]
                        :MkdnExtendList false
                        :MkdnUpdateNumbering [:n :<leader>wN]
                        :MkdnTableFormat [:n :tf]
                        :MkdnTableNewColAfter [:n :ta]
                        :MkdnTableNewColBefore [:n :ti]
                        :MkdnTableNewRowAbove [:n :tO]
                        :MkdnTableNewRowBelow [:n :to]
                        :MkdnTableNextCell [:i :<Tab>]
                        :MkdnTableNextRow [:i :<C-Down>]
                        :MkdnTablePrevCell [:i :<S-Tab>]
                        :MkdnTablePrevRow [:i :<C-Up>]
                        :MkdnFoldSection [:n :zf]
                        :MkdnUnfoldSection [:n :zF]}})

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
   [
     (block_continuation)
     (block_quote_marker)
   ] @punctuation.special
   [
     (backslash_escape)
   ] @string.escape ")

(fn config []
  (let [query (require :vim.treesitter.query)]
    (query.set_query :markdown :highlights md-rule)))

{: opts : config}
