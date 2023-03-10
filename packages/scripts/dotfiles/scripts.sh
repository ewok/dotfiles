#!/usr/bin/env bash
# {{@@ hash_scripts @@}}
set -e

case "{{@@ distro_id @@}}" in
  arch|arcolinux)
    {{@@ yay @@}} aur/ntfy
    ;;
  manjaro-arm)
    {{@@ yay @@}} aur/ntfy
    ;;
  # debian|ubuntu)
  #   sudo apt-get install silversearcher-ag python3-pynvim libtree-sitter-dev luarocks  ripgrep jq yq fzf
  #   ;;
  void)
    {{@@ xi @@}} ntfy
    ;;
esac
