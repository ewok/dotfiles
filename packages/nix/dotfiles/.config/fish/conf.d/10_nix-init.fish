if status --is-interactive
  if ! string match --regex -q 'nix' (mount)
    if test -d ~/.nix-store
      sudo mount -o bind ~/.nix-store /nix
    end
  end
end

if string match --regex -q 'nix' (mount)
  if test -e ~/.nix-profile/etc/profile.d/nix.sh
    fenv source  ~/.nix-profile/etc/profile.d/nix.sh
  end
  fish_add_path --path -a ~/.nix-profile/bin

  if ! command -vq -- nix
    nix-init
  end
end

