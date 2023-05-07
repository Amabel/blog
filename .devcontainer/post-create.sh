#!/bin/zsh

sudo apt update && sudo apt install peco

# Install Dotfiles
echo "Setting up dotfiles..."

wget https://raw.githubusercontent.com/Amabel/dotfiles-for-dev-container/master/.zshrc -O ~/.zshrc
source ~/.zshrc

git clone https://github.com/paulirish/git-open.git $ZSH_CUSTOM/plugins/git-open

git config --global user.name "Amabel"
git config --global user.email "luoweibinb@gmail.com"
