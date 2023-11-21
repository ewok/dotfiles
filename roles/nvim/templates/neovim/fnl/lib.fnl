(lambda map! [mode lhs rhs options desc]
  "Map keybinding"
  (do
    (doto options (tset :desc desc))
    (vim.keymap.set mode lhs rhs options)))

(fn umap! [mode lhs options]
  "Unmap keybinding"
  (vim.keymap.del mode lhs options))

(lambda reg-ft [ft fun ?postfix]
  "Register function for filetype"
  (let [ft_name (.. :ft_ ft (if ?postfix ?postfix ""))]
    (vim.api.nvim_create_augroup ft_name {:clear true})
    (vim.api.nvim_create_autocmd [:FileType]
                                 {:pattern [ft] :callback fun :group ft_name})))

(lambda path-join [...]
  "Join path"
  (table.concat (vim.tbl_flatten [...]) "/"))

(lambda set! [scope key val act]
  "Set option:
    :scope - global, local, ''
    :key - option name
    :val - option value
    :act - append, prepend, get"
  (let [key (tostring key)
        opt (. vim (.. :opt scope) key)]
    (: opt act val)))

(lambda cmd! [...]
  "Execute command"
  (vim.cmd (table.concat (vim.tbl_flatten [...]) "\n")))

(lambda exists? [name]
  "Check if variable exists"
  (not (= 0 (vim.fn.exists name))))

(lambda pack [identifier ?options]
  "A workaround around the lack of mixed tables in Fennel.
  Has special `options` keys for enhanced utility.
  See `:help themis.pack.lazy.pack` for information about how to use it.
  from: https://github.com/datwaft/themis.nvim/blob/main/fnl/themis/pack/lazy.fnl
  "
  (let [options (or ?options {})
        options (collect [k v (pairs options)]
                  (match k
                    :require* (values :config #(require `,v))
                    _ (values k v)))]
    (doto options (tset 1 identifier))))

(fn get_all_win_buf_ft []
  (let [win_tbl (vim.api.nvim_list_wins)
        result []]
    (each [_ win_id (ipairs win_tbl)]
      (if (vim.api.nvim_win_is_valid win_id)
          (let [buf_id (vim.api.nvim_win_get_buf win_id)]
            (table.insert result
                          {: win_id
                           : buf_id
                           :buf_ft (vim.api.nvim_buf_get_option buf_id
                                                                :filetype)}))))
    result))

(fn get_buf_ft [buf_id]
  (vim.api.nvim_buf_get_option buf_id :filetype))

(fn toggle_sidebar [target_ft]
  (let [offset_ft [:NvimTree :undotree :dbui :spectre_panel :mind]]
    (each [_ opts (ipairs (get_all_win_buf_ft))]
      (if (and (not (= opts.buf_ft target_ft))
               (vim.tbl_contains offset_ft opts.buf_ft))
          (vim.api.nvim_win_close opts.win_id true)))))

(fn close_sidebar [target_ft]
  (each [_ opts (ipairs (get_all_win_buf_ft))]
    (if (= opts.buf_ft target_ft)
        (vim.api.nvim_win_close opts.win_id true))))

;; True if filetype in Window otherwise False
(fn is_ft_open? [target_ft]
  (let [result false]
    (each [_ opts (ipairs (get_all_win_buf_ft))]
      (if (= opts.buf_ft target_ft)
          (lua "return true")))))

{: map!
 : umap!
 : reg-ft
 : path-join
 : set!
 : cmd!
 : exists?
 : pack
 : toggle_sidebar
 : get_buf_ft
 : close_sidebar
 : is_ft_open?}
