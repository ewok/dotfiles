#!/bin/bash

sudo pacman -S --needed shellcheck yamllint ansible-lint

sudo npm install -g markdownlint-cli bash-language-server

yay -S --needed --nocleanmenu --nodiffmenu vale-bin hadolint-bin

cat <<EOF> ~/.vale.ini
# Core settings
StylesPath = ci/vale/styles

# The minimum alert level to display (suggestion, warning, or error).
#
# CI builds will only fail on error-level alerts.
MinAlertLevel = warning

# The "formats" section allows you to associate an "unknown" format
# with one of Vale's supported formats.
[formats]
mdx = md

# Global settings (applied to every syntax)
[*]
# List of styles to load
BasedOnStyles = write-good, Joblint
# Style.Rule = {YES, NO} to enable or disable a specific rule
vale.Editorializing = YES
# You can also change the level associated with a rule
vale.Hedging = error

# Syntax-specific settings
# These overwrite any conflicting global settings
[*.{md,txt}]
vale.Editorializing = NO
EOF

if [ -d $HOME/.puppetlsp ]; then rm -rf $HOME/.puppetlsp;fi
git clone --depth 1 https://github.com/lingua-pupuli/puppet-editor-services.git $HOME/.puppetlsp
cd $HOME/.puppetlsp
eval "$(rbenv init -)"
rbenv install 2.5.7
rbenv shell 2.5.7
gem install puppet puppet-lint r10k
bundle install
