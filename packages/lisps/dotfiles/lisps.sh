#!/usr/bin/env bash
# {{@@ hash_lisps @@}}

mkdir -p ~/.cache/rpms ~/Pictures/Screenshots ~/mnt ~/share {{@@ bin @@}}

case "{{@@ distro_id @@}}" in
  arch|arcolinux)
    {{@@ yay @@}} aur/babashka-bin community/clojure community/fennel clj-kondo-bin
    ;;
  manjaro-arm)
    {{@@ yay @@}} aur/babashka-bin community/clojure community/fennel
    ;;
  void)
    {{@@ xi @@}} babashka clojure
      # TODO: via src
      # fennel clj-kondo-bin
    ;;
esac
