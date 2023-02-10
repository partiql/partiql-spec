#!/bin/bash
set -e

BOOTSTRAP_DIR=${HOME}/bootstrap

# Install rbenv
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> ~/.bashrc
echo 'eval "$(~/.rbenv/bin/rbenv init - zsh)"' >> ~/.zshrc

# Make sure we can see rbenv
eval "$(~/.rbenv/bin/rbenv init - bash)"

# Install latest stable Ruby
rbenv install $(rbenv install -l | grep -v - | tail -1)
rbenv global $(rbenv install -l | grep -v - | tail -1)

# Install our required Gems
cd ${BOOTSTRAP_DIR}
bundle install

# Get required fonts for the theme
mkdir -p ${BOOTSTRAP_DIR}/fonts
curl -L -o fonts/vollkorn.zip http://vollkorn-typeface.com/download/vollkorn-4-105.zip
unzip fonts/vollkorn.zip -d fonts/vollkorn
curl -L -o fonts/iosevka.zip https://github.com/be5invis/Iosevka/releases/download/v16.0.2/ttf-iosevka-term-slab-16.0.2.zip
unzip fonts/iosevka.zip -d fonts/iosevka

# Rake doesn't like the ownership of our workspace in the container
git config --global --add safe.directory /workspace