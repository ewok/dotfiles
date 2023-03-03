{ pkgs ? import <nixpkgs> { }, ... }:

with pkgs;
let

  git-crypt-status = writeShellScriptBin "git-crypt-status" ''
    git-crypt status | grep -v not
  '';

  check = writeShellScriptBin "c" ''
    echo *******************START*******************
    git-crypt-status
    echo -n "    checkin local_vars in the repo: "
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

in
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    git-crypt
    git-crypt-status
    check
  ];

  shellHook = ''
    set -e
    export SSH_AUTH_SOCK=/run/user/1000/gnupg/S.gpg-agent.ssh
    CACHEPERIOD=10800 run-cached c
  '';
}
