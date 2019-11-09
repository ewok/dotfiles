sudo pacman -Rsc --needed vim palemoon-bin || echo "Probably absent."
sudo pacman -S --needed yay
yay -Syu --nocleanmenu --nodiffmenu --needed \
    gcc xst vifm neovim albert tmux python2 \
    python3 python-virtualenv ctags global unzip \
    ripgrep zsh-autosuggestions restic trash-cli \
    siji-git ttf-unifont nerd-fonts-noto-sans-mono \
    flameshot todoist-add-git nvme-cli todoist-linux-bin \
    slack-desktop redshift-gtk-git zeal npm xclip \
    xsel par mbsync msmtp neomutt notmuch notmuch-mutt \
    davmail goobook lbdb vcal cht.sh sshfs curlftpfs \
    archivemount autorandr minetime-bin timeshift \
    rbenv ruby-build xkb-switch
