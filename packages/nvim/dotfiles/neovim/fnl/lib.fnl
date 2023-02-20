(lambda map! [mode lhs rhs options desc]
  "Map keybinding"
  (do
    (doto options (tset :desc desc))
    (vim.keymap.set mode lhs rhs options)))


(fn umap! [mode lhs options]
  "Unmap keybinding"
  (vim.keymap.del mode lhs options))


(lambda reg-ft [ft fun]
  "Register function for filetype"
  (let [ft_name (.. :ft ft)]
    (vim.api.nvim_create_augroup ft_name {:clear true})
    (vim.api.nvim_create_autocmd [:FileType]
                                 {:pattern [ft] :callback fun :group ft_name})))


(lambda path-join [...]
  "Join path"
  (table.concat (vim.tbl_flatten [ ... ]) "/"))


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
  (vim.cmd (table.concat (vim.tbl_flatten [ ... ]) "\n")))


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
                    :require* (values :config #(require ,v))
                    _ (values k v)))]
    (doto options (tset 1 identifier))))


{: map! : umap! : reg-ft : path-join : set! : cmd! : exists? : pack}
