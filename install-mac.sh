#!/bin/bash


echo -e 'Installing JVM land...'
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 11.0.15-zulu
sdk install sbt 1.5.5
sdk install scala 2.13.6

echo -e 'Installing javascript land...'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
nvm install 16

# For Metals
brew install coursier/formulas/coursier

brew install tmux

brew install neovim

# For nvim-tree
brew install ripgrep

# Symlink neovim conf.
ln -s ~/.dotfiles/nvim/ ~/.config/

# Symlink tmux conf.
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

