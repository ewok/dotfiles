{ pkgs ? import <nixpkgs> {}, ... }:

with pkgs;
let

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
    curl -sL 'https://github.com/ewok/dotfiles/raw/main/local_vars.yaml' | md5sum -c local_vars.yaml.md5
    if [ $? -ne 0 ]; then
      echo WARNING WARNING settings.yaml does not match hash!
      exit 1
    fi
    echo ********************END********************
  '';
}
