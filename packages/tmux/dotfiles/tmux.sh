#!/usr/bin/env bash
{{@@ hash_tmux @@}}
# {{@@ hash_terraform @@}}
set -e

case "{{@@ distro_id @@}}" in
  arch|arcolinux|manjaro-arm)
    {{@@ yay @@}} community/tmux
    ;;
  # debian|ubuntu)
  #   sudo apt-get install silversearcher-ag python3-pynvim libtree-sitter-dev luarocks  ripgrep jq yq fzf
  #   ;;
  void)
    {{@@ xi @@}} tmux
    ;;
esac

# sudo usermod -aG tfenv $USER
