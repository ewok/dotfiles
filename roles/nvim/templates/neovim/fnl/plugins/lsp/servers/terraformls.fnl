(local util (require :lspconfig/util))

{:cmd [:terraform-ls :serve]
 :filetypes [:terraform :terraform-vars]
 :root_dir (util.root_pattern :.root :.terraform :.git :terraform.tf)}
