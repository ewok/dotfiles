#!/usr/bin/env bash
# {{@@ hash_nvim @@}}
set -e

case "{{@@ distro_id @@}}" in
  arch|arcolinux)
    {{@@ yay @@}} neovim lazygit the_silver_searcher ripgrep python-pynvim tree-sitter npm gnu-netcat jq yq fzf
    ;;
  manjaro-arm)
    {{@@ yay @@}} aur/babashka-bin community/clojure community/fennel
    ;;
  debian|ubuntu)
    sudo apt-get install silversearcher-ag python3-pynvim libtree-sitter-dev luarocks  ripgrep jq yq fzf
    ;;
  void)
    {{@@ xi @@}} neovim lazygit the_silver_searcher ripgrep tree-sitter netcat jq yq fzf
      # TODO: via src
      # fennel npm
    ;;
esac

curl -o {{@@ bin @@}}/coursier https://git.io/coursier-cli
