{ pkgs ? import <nixpkgs> { }, ... }:

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
    SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    echo *******************START*******************
    git-crypt-status
    curl -sL 'https://github.com/ewok/dotfiles/raw/main/local_vars.yaml' | md5sum -c local_vars.yaml.md5
    if [ $? -ne 0 ]; then
      echo WARNING WARNING settings.yaml does not match hash!
      echo -n "Expecting: "
      cat local_vars.yaml.md5
      echo -n "Got: "
      curl -sL 'https://github.com/ewok/dotfiles/raw/main/local_vars.yaml' | md5sum
      exit 1
    fi
    echo ********************END********************
  '';
}
