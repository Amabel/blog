#!/bin/bash

# Install Dotfiles
git clone --depth=1 https://github.com/Amabel/dotfiles.git /workspaces/dotfiles
rm -rf /workspaces/dotfiles/.git /workspaces/dotfiles/README.md
mv -f /workspaces/dotfiles/{.,}* ~
rm -rf /workspaces/dotfiles
source ~/.zshrc