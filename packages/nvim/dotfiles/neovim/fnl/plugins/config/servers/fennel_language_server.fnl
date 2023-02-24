(local util (require :lspconfig.util))

{:root_dir (util.root_pattern :fnl)
 :settings {:fennel {:workspace {:library (vim.api.nvim_list_runtime_paths)}
                     :diagnostics {:globals [:vim :conf]}}}}
