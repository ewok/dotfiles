#!/usr/bin/env bash
# {{@@ hash_terraform @@}}
set -e

case "{{@@ distro_id @@}}" in
  arch|arcolinux|manjaro-arm)
    {{@@ yay @@}} aur/tfenv aur/helmenv-bin aur/tgenv
    ;;
  # debian|ubuntu)
  #   sudo apt-get install silversearcher-ag python3-pynvim libtree-sitter-dev luarocks  ripgrep jq yq fzf
  #   ;;
  void)
    echo nope
    # TODO: inst from src
    # {{@@ xi @@}} tfenv helmenv-bin tgenv
    ;;
esac

# sudo usermod -aG tfenv $USER
