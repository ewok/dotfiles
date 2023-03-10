#!/usr/bin/env bash
# {{@@ hash_kube @@}}

case "{{@@ distro_id @@}}" in
  arch|arcolinux)
    {{@@ yay @@}} kubectl kubectx
    ;;
  void)
    {{@@ xi @@}} kubectl
      # TODO: install via src
      # kubectx
    ;;
esac
