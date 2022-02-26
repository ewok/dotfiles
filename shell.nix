{ pkgs ? import <nixpkgs> {}, ... }:

with pkgs;
let

  rebuildTools = writeScriptBin "rebuild-tools" ''
    #!/bin/fish
    run host rebuild-tools $argv
  '';

  update = writeScriptBin "rebuild-os" ''
    #!/bin/fish
    run host rebuild-os $argv
  '';

  git-crypt-status = writeShellScriptBin "git-crypt-status" ''
    git-crypt status | grep -v not
  '';

in
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    git-crypt
    git-crypt-status
  ];

  shellHook = ''
    # PATH=${nix}/bin:$PATH
    echo *******************START*******************
    git-crypt-status
    curl -sL 'https://github.com/ewok/fedora-config/raw/main/settings.yaml' | md5sum -c settings.yaml.md5
    if [ $? -ne 0 ]; then
      echo WARNING WARNING settings.yaml does not match hash!
      exit 1
    fi
    echo ********************END********************
  '';
}
