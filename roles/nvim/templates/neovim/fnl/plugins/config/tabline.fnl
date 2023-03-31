(local {: map!} (require :lib))

(local buff_hint "^^     Buffers           ^^     Tabs
 ^^---------------        ^^---------------
 _l_, _h_: next/previous  ^^ _L_, _H_: next/previous
 _d_: delete              ^^ _D_: delete
 _a_: new                 ^^ _A_: new
 _o_: remain only         ^^ _O_: remain only

 _q_, _c_: close
 ")

(fn init []
  (map! :n :<C-W>d :<cmd>BufferDelete<cr> {:silent true} "Close current buffer")
  (map! :n :<C-W><C-D> :<cmd>BufferDelete<cr> {:silent true}
        "Close current buffer"))

(fn config []
  (let [tabline (require :tabline)
        hydra (require :hydra)]
    (tabline.setup {:enable true
                    :options {:show_tabs_always true
                              :show_devicons true
                              :show_filename_only true
                              :modified_italic true}})
    (let [buff_tabs (hydra {:name :Buffers/Tabs
                            :hint buff_hint
                            :config {:hint {:border :rounded}
                                     :on_key (fn []
                                               (vim.wait 200
                                                         (fn []
                                                           (vim.cmd :redraw))
                                                         30 false))}
                            ; :mode :n
                            ; :body :<leader>b
                            :heads [[:l
                                     #(vim.cmd :TablineBufferNext)
                                     {:on_key false}]
                                    [:h
                                     #(vim.cmd :TablineBufferPrevious)
                                     {:on_key false}]
                                    [:d
                                     #(vim.cmd :BufferDelete)
                                     {:desc :delete}]
                                    [:a
                                     #(vim.cmd :enew)
                                     {:desc :new :exit true}]
                                    [:o
                                     #(vim.cmd :BufOnly)
                                     {:desc :only :exit true}]
                                    [:L #(vim.cmd :tabnext) {:on_key false}]
                                    [:H
                                     #(vim.cmd :tabprevious)
                                     {:on_key false}]
                                    [:D #(vim.cmd :tabclose) {:desc :delete}]
                                    [:A
                                     #(vim.cmd :$tabnew)
                                     {:desc :new :exit true}]
                                    [:O
                                     #(vim.cmd :tabonly)
                                     {:desc :only :exit true}]
                                    [:q nil {:exit true :desc false}]
                                    [:c nil {:exit true :desc false}]]})]
      (map! :n :<leader>b #(: buff_tabs :activate) {} :Buffers/Tabs)
      (map! :n :<S-Tab> #(do
                           (vim.cmd :TablineBufferPrevious)
                           (: buff_tabs :activate)) {}
            :Buffers/Tabs)
      (map! :n :<Tab> #(do
                         (vim.cmd :TablineBufferNext)
                         (: buff_tabs :activate)) {}
            :Buffers/Tabs))))

{: config : init}
