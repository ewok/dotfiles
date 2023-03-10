#!/usr/bin/env bash
{{@@ hash_vifm @@}}
# {{@@ hash_terraform @@}}
set -e

case "{{@@ distro_id @@}}" in
  arch|arcolinux|manjaro-arm)
    {{@@ yay @@}} extra/zip community/vifm extra/unzip extra/p7zip community/sshfs community/curlftpfs community/trash-cli aur/archivemount-git aur/epr-git
    ;;
  # debian|ubuntu)
  #   sudo apt-get install silversearcher-ag python3-pynvim libtree-sitter-dev luarocks  ripgrep jq yq fzf
  #   ;;
  void)
    {{@@ xi @@}} zip vifm unzip p7zip fuse-sshfs curlftpfs trash-cli fuse-archivemount
      # TODO: via src
      # epr
    ;;
esac
