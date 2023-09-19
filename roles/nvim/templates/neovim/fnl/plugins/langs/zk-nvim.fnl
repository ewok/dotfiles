(local {: pack : map!} (require :lib))

(fn config []
  (let [zk (require :zk)
        telescope (require :telescope)]
    (zk.setup {:picker :telescope})
    (telescope.load_extension :zk)))

(fn init []
  (let [md {:noremap true :silent false}]
    (map! [:n] :<leader>wn "<cmd>ZkNew { title = vim.fn.input('Title: ') }<cr>"
          md "New note")
    (map! [:n] :<leader>wi :<cmd>ZkIndex<cr> md "Reindex notes")
    (map! [:n] :<leader>wo "<cmd>ZkNotes { sort = { 'modified' } }<cr>" md
          "Open note")
    (map! [:n] :<leader>wt :<cmd>ZkTags<cr> md "Open tag")
    (map! [:n] :<leader>wf
          "<cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<cr>"
          md "Find in notes")
    (map! [:v] :<leader>wf ":'<,'>ZkMatch<cr>" md "Find in notes")))

(pack :mickael-menu/zk-nvim
      {: config : init :cmd [:ZkNew :ZkIndex :ZkNotes :ZkTags :ZkMatch]})
