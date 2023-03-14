if ! mount | grep -q nix; then
  if [ -d $HOME/.nix-store ]; then
    sudo mount -o bind $HOME/.nix-store /nix
  fi
fi

if mount | grep -q nix; then
  if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
  export PATH=$HOME/.nix-profile/bin:$PATH
  if ! command -v nix >/dev/null; then
    nix-init
  fi
fi
