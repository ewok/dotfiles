(local {: map!} (require :lib))

(fn init []
  (map! [:n] :<leader>fn ":Notifications<cr>" {:silent true}
        "Find notices history"))

(fn config []
  (let [notify (require :notify)
        notify-options {:background_colour (if conf.options.transparent
                                               "#1E1E2E"
                                               "#000000")
                        :stages :fade
                        :timeout 3000
                        :fps 120
                        :icons {:ERROR conf.icons.diagnostic.Error
                                :WARN conf.icons.diagnostic.Warn
                                :INFO conf.icons.diagnostic.Hint}}]
    (notify.setup notify-options)
    (set vim.notify notify)))

{: config : init}
