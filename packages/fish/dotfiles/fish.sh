#!/usr/bin/env bash
# {{@@ hash_fish @@}}

case "{{@@ distro_id @@}}" in
  arch|arcolinux)
    {{@@ yay @@}} community/fish community/zoxide community/exa community/bat community/dfc community/fd community/global aur/viddy
    ;;
  void)
    {{@@ xi @@}} fish-shell zoxide exa bat dfc fd global
      # TODO: Install it from src
      # viddy
    ;;
esac
