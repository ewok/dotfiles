(fn config []
  (set vim.g.vsnip_snippet_dir conf.options.snippets_directory)
  (set vim.g.vsnip_filetypes
       {:javascript [:typescript]
        :typescript [:javascript]
        :vue [:javascript :typescript]})
  (vim.cmd "
                  imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
                  smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
                  imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
                  smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'"))

{: config}
