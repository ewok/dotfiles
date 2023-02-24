(local util (require :lspconfig.util))

{:filetypes [:sh :zsh :bash]
 :single_file_support true
 :cmd [:bash-language-server :start]
 :root_dir (util.find_git_ancestor)}
