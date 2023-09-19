(local util (require :lspconfig/util))

{:root_dir (util.root_pattern :.root :.terraform :.git :terraform.tf)}
