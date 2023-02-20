(local {: map! : umap!} (require :lib))

(fn open_callback [term]
  (map! :t :<C-J> "<c-\\><c-n><cmd>TmuxNavigateDown<cr>" {:silent true} :Down)
  (map! :t :<C-H> "<c-\\><c-n><cmd>TmuxNavigateLeft<cr>" {:silent true} :Left)
  (map! :t :<C-L> "<c-\\><c-n><cmd>TmuxNavigateRight<cr>" {:silent true} :Right)
  (map! :n :<C-N> :i<C-N> {:silent true :buffer term.bufnr} :Next)
  (map! :n :<C-P> :i<C-P> {:silent true :buffer term.bufnr} :Previous)
  (map! :n :<C-C> :i<C-C> {:silent true :buffer term.bufnr} :Break)
  (map! :t :<C-U> "<c-\\><c-n><C-U>" {:silent true :buffer term.bufnr}
        :ScrollUp)
  (map! :t :<C-Y> "<c-\\><c-n><C-Y>" {:silent true :buffer term.bufnr}
        :ScrollOneUp)
  (map! :n :<CR> :i {:silent true :buffer term.bufnr} :Enter)
  (vim.cmd :startinsert))

(fn open_callback_float [term]
  (vim.cmd :startinsert)
  (umap! :t :<esc>)
  (map! :t :<esc> "<c-\\><c-n><cmd>close<cr>" {:silent true :buffer term.bufnr}
        "Escape float terminal")
  (map! :n :<C-N> :i<C-N> {:silent true :buffer term.bufnr} :Next)
  (map! :n :<C-P> :i<C-P> {:silent true :buffer term.bufnr} :Previous)
  (map! :n :<C-C> :i<C-C> {:silent true :buffer term.bufnr} :Break)
  (map! :t :<C-U> "<c-\\><c-n><C-U>" {:silent true :buffer term.bufnr}
        :ScrollUp)
  (map! :t :<C-Y> "<c-\\><c-n><C-Y>" {:silent true :buffer term.bufnr}
        :ScrollOneUp)
  (map! :n :<CR> :i {:silent true :buffer term.bufnr} :Enter)
  (map! :n :<esc> :<cmd>close<cr> {:silent true :buffer term.bufnr} :Close))

; local function lazy_open_callback(term)
(fn open_callback_lazygit [term]
  (vim.cmd :startinsert)
  (umap! :t :<esc>)
  (map! :i :q :<cmd>close<cr> {:silent true :buffer term.bufnr}
        "Escape lazygit terminal"))

(fn close_callback []
  (map! :t :<esc> "<c-\\><c-n>" {:silent true} "Escape terminal insert mode"))

(fn config []
  (let [toggleterm (require :toggleterm)
        shell (if (= 1 (vim.fn.executable :fish)) :fish :bash)]
    (toggleterm.setup {:start_in_insert false
                       :shade_terminals true
                       :shading_factor 1
                       :size (fn [term]
                               (if (= :horizontal (. term :direction))
                                   (* vim.o.lines 0.25)
                                   (* vim.o.columns 0.25)))
                       :on_open (fn [] (vim.wo.spell false))
                       :highlights {:Normal {:link :Normal}
                                    :NormalFloat {:link :NormalFloat}
                                    :FloatBorder {:link :FloatBorder}}
                       : shell})
    (let [terminal (require :toggleterm.terminal)
          terms terminal.Terminal]
      ;; Horizontal terminal at the bottom
      (map! :n :<leader>tt
            #(let [horizontal (: terms :new
                                 {:direction :horizontal
                                  :on_open open_callback
                                  :on_close close_callback})]
               (: horizontal :toggle)) {:silent true}
            "Toggle bottom or vertical terminal")
      ;; Float terminal
      (map! :n :<leader>tf #(let [float (: terms :new
                                           {:hidden true
                                            :count 120
                                            :direction :float
                                            :float_opts {:border (if conf.options.float_border
                                                                     :double
                                                                     :none)}
                                            :on_open open_callback_float
                                            :on_close close_callback})]
                              (: float :toggle))
            {:silent true} "Toggle floating terminal")
      ;; Lazygit file history
      (map! :n :<leader>glf #(let [lazygit (: terms :new
                                              {:cmd (.. "lazygit log -f "
                                                        (vim.fn.expand "%"))
                                               :hidden true
                                               :count 130
                                               :direction :float
                                               :float_opts {:border (if conf.options.float_border
                                                                        :double
                                                                        :none)
                                                            :height (- vim.o.lines
                                                                       6)
                                                            :width (- vim.o.columns
                                                                      6)}
                                               :on_open open_callback_lazygit
                                               :on_close close_callback})]
                               (: lazygit :toggle))
            {:silent true} "Git file history")
      ;; Lazygit
      (each [key info (pairs {:<leader>gg {:cmd "lazygit branch"
                                           :desc "Git branch"}
                              :<leader>gll {:cmd "lazygit log" :desc "Git log"}
                              :<leader>gs {:cmd :lazygit :desc "Git status"}})]
        (map! :n key #(let [lazygit (: terms :new
                                       {:cmd info.cmd
                                        :hidden true
                                        :count 130
                                        :direction :float
                                        :float_opts {:border (if conf.options.float_border
                                                                 :double
                                                                 :none)
                                                     :height (- vim.o.lines 6)
                                                     :width (- vim.o.columns 6)}
                                        :on_open open_callback_lazygit
                                        :on_close close_callback})]
                        (: lazygit :toggle))
              {:silent true} info.desc)))))

{: config}
