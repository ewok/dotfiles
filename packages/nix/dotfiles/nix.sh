#!/usr/bin/env bash
# {{@@ hash_nix @@}}

case "{{@@ distro_id @@}}" in
  void)
    {{@@ xi @@}} xz
    sudo xbps-remove python-pip python-setuptools python
    ;;
esac
