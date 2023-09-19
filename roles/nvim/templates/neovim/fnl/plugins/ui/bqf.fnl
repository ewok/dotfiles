;; Better QF
(local {: pack : map!} (require :lib))

(fn init []
  (map! :n :<leader>tq (fn []
                         (var qf_exists false)
                         (each [_ win (pairs (vim.fn.getwininfo))
                                &until qf_exists]
                           (if (= (. win :quickfix) 1)
                               (set qf_exists true)))
                         (if qf_exists (vim.cmd :cclose)
                             (if (not (vim.tbl_isempty (vim.fn.getqflist)))
                                 (vim.cmd :copen))))
        {:silent true} "Toggle bqf"))

(fn config []
  (let [bqf (require :bqf)]
    (bqf.setup {:func-map {:tab :<C-t> :vsplit :<C-v> :split :<C-s>}
                :filter {:fzf {:action-for {:ctrl-t :tabedit
                                            :ctrl-v :vsplit
                                            :ctrl-s :split}}}})))

(pack :kevinhwang91/nvim-bqf {: config : init})
