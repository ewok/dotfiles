#!/usr/bin/env bash
# {{@@ hash_git @@}}

case "{{@@ distro_id @@}}" in
  arch|arcolinux)
    {{@@ yay @@}} git-crypt git-trim pass-git-helper git-extras git-filter-repo
    ;;
  void)
    {{@@ xi @@}} git-crypt pass-git-helper git-extras git-filter-repo
      # TODO: install via src
      # git-trim 
    ;;
esac
