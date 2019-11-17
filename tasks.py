"""Installation script."""
import os
from invoke import task

from helpers import makesl, npm_i, yay, pacman_remove, install_gitrepo, install_virtualenv


@task
def ensure_yay_exists(c):
    """Ensure yay command exists."""
    c.run("sudo pacman -S yay --needed")


@task
def install_base(c):
    """Install base software."""
    packages_to_install = [
        "gcc", "xst", "albert", "tmux", "python2",
        "python3", "python-virtualenv", "unzip", "p7zip",
        "zsh-autosuggestions", "restic", "trash-cli",
        "siji-git", "ttf-unifont", "nerd-fonts-noto-sans-mono",
        "nvme-cli", "xclip", "xsel", "par", "sshfs", "curlftpfs",
        "archivemount", "autorandr", "timeshift",
        "rbenv", "ruby-build", "moc", "jq"
    ]

    paths_to_link = [
        ("config/.tmux.conf", ".tmux.conf"),
        ("config/.zshrc", ".zshrc"),
        ("config/.zsh", ".zsh"),
        ("config/.zprofile", ".zprofile"),
        ("config/.i3", ".i3"),
        ("config/.i3status.conf", ".i3status.conf"),
        ("config/.xprofile", ".xprofile"),
        ("config/.profile", ".profile"),
        ("config/.Xresources", ".Xresources"),
        ("config/.skhdrc", ".skhdrc"),
        ("config/.yabairc", ".yabairc"),
        ("bin", "bin"),
        ("config/albert/modules", ".local/share/albert/org.albert.extension.python/modules"),
        ("config/albert/albert.conf", ".config/albert/albert.conf"),
    ]

    packages_to_remove = [
        'vim', 'palemoon-bin'
    ]

    gitrepos_to_install = [
        ("https://github.com/junegunn/fzf.git", ".fzf"),
        ("https://github.com/tmux-plugins/tmux-resurrect", ".tmux/resurrect"),
        ("git://github.com/robbyrussell/oh-my-zsh.git", ".oh-my-zsh"),
    ]

    pacman_remove(c, packages_to_remove)

    yay(c, packages_to_install)

    for pair in paths_to_link:
        makesl(pair[0], os.path.join(os.environ['HOME'], pair[1]))

    for pair in gitrepos_to_install:
        install_gitrepo(c, pair[0], os.path.join(os.environ['HOME'], pair[1]))

    # FZF Installation
    c.run("$HOME/.fzf/install --no-bash --no-fish --no-update-rc --key-bindings --completion")


@task
def install_gui_tools(c):
    """Install packages."""
    packages_to_install = [
        "flameshot", "todoist-add-git", "todoist-linux-bin",
        "slack-desktop", "redshift-gtk-git", "zeal", "minetime-bin",
        "cawbird", "masterpdfeditor-free"
    ]

    yay(c, packages_to_install)


@task
def install_mail(c):
    """Install mail software."""
    packages_to_install = [
        "mbsync", "msmtp", "neomutt", "notmuch", "notmuch-mutt",
        "davmail", "goobook", "lbdb", "vcal",
    ]

    paths_to_link = [
        ("config/.mbsyncrc", ".mbsyncrc"),
        ("config/.msmtp", ".msmtp"),
        ("config/muttrc", ".muttrc"),
        ("config/mutt", ".mutt")
    ]

    yay(c, packages_to_install)

    for pair in paths_to_link:
        makesl(pair[0], os.path.join(os.environ['HOME'], pair[1]))


@task
def install_editor(c):
    """Install editor and all editor tools."""
    packages_to_install = [
        "vifm", "neovim", "ctags", "global", "the_silver_searcher",
        "xkb-switch", "cht.sh", "shellcheck", "yamllint",
        "vale-bin", "hadolint-bin"
    ]

    paths_to_link = [
        ("config/.vim", ".vim"),
        ("config/.vim", ".config/nvim"),
        ("config/.ideavimrc", ".ideavimrc"),
        ("config/.vifm", ".vifm"),
        ("config/.vifm", ".config/vifm"),
        ("config/.ctags", ".ctags"),
    ]

    npm_packages_to_install = [
        "markdownlint-cli", "bash-language-server"
    ]

    virtualenvs = [
        ("share/venv/neovim2", "python2", ['neovim', 'pynvim']),
        ("share/venv/neovim3", "python3", ['neovim', 'pynvim']),
    ]

    yay(c, packages_to_install)

    npm_i(c, npm_packages_to_install)

    for pair in paths_to_link:
        makesl(pair[0], os.path.join(os.environ['HOME'], pair[1]))

    for element in virtualenvs:
        install_virtualenv(c, os.path.join(os.environ['HOME'], element[0]), element[1], element[2])

    c.run("nvim +PlugInstall +qall")

# Not implemented yet
# cat <<EOF> ~/.vale.ini
#  # Core settings
#  StylesPath = ci/vale/styles

#  # The minimum alert level to display (suggestion, warning, or error).
#  #
#  # CI builds will only fail on error-level alerts.
#  MinAlertLevel = warning

#  # The "formats" section allows you to associate an "unknown" format
#  # with one of Vale's supported formats.
#  [formats]
#  mdx = md

#  # Global settings (applied to every syntax)
#  [*]
#  # List of styles to load
#  BasedOnStyles = write-good, Joblint
#  # Style.Rule = {YES, NO} to enable or disable a specific rule
#  vale.Editorializing = YES
#  # You can also change the level associated with a rule
#  vale.Hedging = error

#  # Syntax-specific settings
#  # These overwrite any conflicting global settings
#  [*.{md,txt}]
#  vale.Editorializing = NO
#  EOF

#  if [ -d $HOME/.puppetlsp ]; then rm -rf $HOME/.puppetlsp;fi
#  git clone --depth 1 https://github.com/lingua-pupuli/puppet-editor-services.git $HOME/.puppetlsp
#  cd $HOME/.puppetlsp
#  eval "$(rbenv init -)"
#  rbenv install 2.5.7
#  rbenv shell 2.5.7
#  gem install puppet puppet-lint r10k
#  bundle install


@task(ensure_yay_exists, install_base, install_gui_tools, install_mail, install_editor)
def install(c):
    """Install all."""
    print("Done")
