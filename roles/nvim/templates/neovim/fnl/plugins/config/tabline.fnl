(local {: map!} (require :lib))

(fn init []
  (map! :n :<C-W>d :<cmd>BufferDelete<cr> {:silent true} "Close current buffer")
  (map! :n :<C-W><C-D> :<cmd>BufferDelete<cr> {:silent true}
        "Close current buffer")
  (map! :n :<S-Tab> :<cmd>TablineBufferPrevious<cr> {:silent true}
        "Go to left buffer")
  (map! :n :<Tab> :<cmd>TablineBufferNext<cr> {:silent true}
        "Go to right buffer")
  (map! :n :<leader>bn :<cmd>enew<cr> {:silent true} "Create new buffer")
  (map! :n :<leader>bd :<cmd>BufferDelete<cr> {:silent true}
        "Close current buffer")
  (map! :n :<leader>bo :<cmd>BufOnly<cr> {:silent true}
        "Close all buffers except current"))

(fn config []
  (let [tabline (require :tabline)]
    (tabline.setup {:enable true
                    :options {:show_tabs_always true
                              :show_devicons true
                              :modified_italic true}})))

{: config : init}
