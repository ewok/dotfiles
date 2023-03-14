function nixify
  if not test -e ./.envrc
    echo "
if ! has nix_direnv_version || ! nix_direnv_version 2.2.1; then
  source_url "https://raw.githubusercontent.com/nix-community/nix-direnv/2.2.1/direnvrc" "sha256-zelF0vLbEl5uaqrfIzbgNzJWGmLzCmYAkInj/LNxvKs="
fi
use nix" > .envrc
    direnv allow
  end
  if not test -e shell.nix; and not test -e default.nix
    echo "\
with import <nixpkgs> {};
mkShell {
  nativeBuildInputs = [
    bashInteractive
  ];
}" > default.nix
  else
    echo "shell.nix already exists"
  end
end

function flakify
  if not test -e flake.nix
    nix flake new -t github:nix-community/nix-direnv .
  else if not test -e .envrc
    echo "use flake" > .envrc
    direnv allow
  else
    echo "flake already exists"
  end
end
