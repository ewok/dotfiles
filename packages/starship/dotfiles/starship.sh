#!/usr/bin/env bash
# {{@@ hash_starship @@}}
set -e

case "{{@@ distro_id @@}}" in
  arch|arcolinux|manjaro-arm)
    {{@@ yay @@}} community/starship
    ;;
  # debian|ubuntu)
  #   sudo apt-get install silversearcher-ag python3-pynvim libtree-sitter-dev luarocks  ripgrep jq yq fzf
  #   ;;
  void)
    {{@@ xi @@}} starship
    ;;
esac
