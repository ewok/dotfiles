#!/usr/bin/env bash
# {{@@ hash_direnv @@}}

case "{{@@ distro_id @@}}" in
  arch|arcolinux)
    {{@@ yay @@}} community/direnv
    ;;
  void)
    {{@@ xi @@}} direnv
    ;;
esac
