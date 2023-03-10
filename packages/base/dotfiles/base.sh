#!/usr/bin/env bash
# {{@@ hash_base @@}}

mkdir -p ~/Pictures/Screenshots ~/mnt ~/share {{@@ bin @@}}

case "{{@@ distro_id @@}}" in
  arch|arcolinux)
    {{@@ yay @@}} base-devel community/btop
    ;;
  void)
    {{@@ xi @@}} btop git curl xtools
    sudo xbps-remove python-pip python-setuptools python
    ;;
esac
