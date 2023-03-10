#!/usr/bin/env bash
{{@@ hash_subversion @@}}
set -e

case "{{@@ distro_id @@}}" in
  arch|arcolinux|manjaro-arm)
    {{@@ yay @@}} extra/subversion
    ;;
  # debian|ubuntu)
  #   sudo apt-get install silversearcher-ag python3-pynvim libtree-sitter-dev luarocks  ripgrep jq yq fzf
  #   ;;
  void)
    {{@@ xi @@}} subversion
    ;;
esac
