(local {: pack} (require :lib))

(pack :allaman/kustomize.nvim {:requires :nvim-lua/plenary.nvim
                               :ft :yaml
                               :config true})
