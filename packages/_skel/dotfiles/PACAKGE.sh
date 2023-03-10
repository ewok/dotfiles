#!/usr/bin/env bash
# {{@@ hash_PACKAGE @@}}

case "{{@@ distro_id @@}}" in
  arch|arcolinux)
    echo arch
    ;;
  void)
    echo void
    ;;
esac
