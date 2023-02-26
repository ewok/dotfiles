{
  description = "A basic flake with a shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        git-crypt-status = pkgs.writeShellScriptBin "git-crypt-status" ''
          git-crypt status | grep -v not
        '';
      in
      {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            git-crypt
            git-crypt-status
          ];
          packages = [ pkgs.bashInteractive ];
          shellHook = ''
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
        };
      });
}
