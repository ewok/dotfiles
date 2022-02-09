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
    update
    rebuildTools

    git-crypt
    git-crypt-status
  ];

  shellHook = ''
    # PATH=${nix}/bin:$PATH
    git-crypt-status
  '';
}
