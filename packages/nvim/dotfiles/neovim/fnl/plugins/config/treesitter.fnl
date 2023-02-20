;; TreeSitter
(local ignore_install [:ada
                       :agda
                       :arduino
                       :astro
                       :bibtex
                       :blueprint
                       :capnp
                       :chatito
                       :cooklang
                       :css
                       :cuda
                       :ebnf
                       :eex
                       :elixir
                       :elm
                       :elsa
                       :elvish
                       :erlang
                       :foam
                       :fortran
                       :fsh
                       :func
                       :fusion
                       :gdscript
                       :gleam
                       :glimmer
                       :glsl
                       :hack
                       :heex
                       :hlsl
                       :hocon
                       :kdl
                       :kotlin
                       :lalrpop
                       :m68k
                       :menhir
                       :mermaid
                       :meson
                       :ninja
                       :ocaml
                       :ocaml_interface
                       :ocamllex
                       :pascal
                       :php
                       :phpdoc
                       :pioasm
                       :poe_filter
                       :prisma
                       :pug
                       :qmljs
                       :r
                       :racket
                       :rego
                       :rnoweb
                       :ron
                       :ruby
                       :scss
                       :slint
                       :smali
                       :smithy
                       :solidity
                       :supercollider
                       :surface
                       :svelte
                       :swift
                       :sxhkdrc
                       :t32
                       :thrift
                       :tiger
                       :tlaplus
                       :tsx
                       :turtle
                       :twig
                       :typescript
                       :v
                       :verilog
                       :vhs
                       :wgsl
                       :wgsl_bevy
                       :yang
                       :zig])

(fn config []
  (let [configs (require :nvim-treesitter.configs)]
    (configs.setup {:ensure_installed :all
                    : ignore_install
                    :highlight {:enable true
                                :additional_vim_regex_highlighting false}
                    :indent {:enable true :disable [:yaml :python :html :vue]}
                    ; -- incremental selection
                    :incremental_selection {:enable false
                                            :keymaps {:init_selection :<cr>
                                                      :node_incremental :<cr>
                                                      :node_decremental :<bs>
                                                      :scope_incremental :<tab>}}
                    ; -- nvim-ts-rainbow
                    :rainbow {:enable conf.options.rainbow_parents
                              :extended_mode true
                              :max_file_lines 1000}
                    ; -- nvim-ts-autotag
                    :autotag {:enable true}
                    ; -- nvim-ts-context-commentstring
                    :context_commentstring {:enable true :enable_autocmd false}})))

{: config}
