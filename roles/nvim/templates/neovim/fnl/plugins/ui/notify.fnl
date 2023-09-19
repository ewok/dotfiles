;; Notify
(local {: pack : map!} (require :lib))

(fn init []
  (map! [:n] :<leader>fn ":Notifications<cr>" {:silent true}
        "Find notices history"))

(fn config []
  (let [notify (require :notify)
        notify-options {:background_colour (if conf.options.transparent
                                               "#1E1E2E"
                                               "#000000")
                        :stages :fade
                        :timeout 1500
                        :fps 120
                        :on_open (fn [win]
                                   (vim.api.nvim_win_set_config win
                                                                {:focusable false}))
                        :icons {:ERROR conf.icons.diagnostic.Error
                                :WARN conf.icons.diagnostic.Warn
                                :INFO conf.icons.diagnostic.Info}}]
    (notify.setup notify-options)
    (set vim.notify notify)))

(pack :rcarriga/nvim-notify {: config : init})
