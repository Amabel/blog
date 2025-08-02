#!/bin/zsh

sudo apt update && sudo apt install peco

# Install Dotfiles
echo "Setting up dotfiles..."

wget https://raw.githubusercontent.com/Amabel/dotfiles-for-dev-container/master/.zshrc -O ~/.zshrc

# Download Claude configuration files
echo "Setting up Claude configuration..."

# Use git sparse-checkout to download only .claude directory
git clone --filter=blob:none --sparse https://github.com/Amabel/dotfiles-for-dev-container.git /tmp/dotfiles
cd /tmp/dotfiles
git sparse-checkout set .claude
cp -r .claude ~/.claude
cd ~
rm -rf /tmp/dotfiles

source ~/.zshrc

git clone https://github.com/paulirish/git-open.git $ZSH_CUSTOM/plugins/git-open

git config --global user.name "Amabel"
git config --global user.email "luoweibinb@gmail.com"

# Add Claude MCPs
claude mcp add --transport http context7 https://mcp.context7.com/mcp
claude mcp add -s user -t http deepwiki https://mcp.deepwiki.com/mcp
claude mcp add playwright npx @playwright/mcp@latest
