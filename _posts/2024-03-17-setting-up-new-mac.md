---
title: '新 Mac 环境配置指南'
date: 2024-03-17 10:30:00 +0900
# categories: ['']
tags: ['Mac']
# img_path: /assets/images/2022-xx-xx-template/
# image:
#   path: cover.png
#   width: 300
#   height: 200
published: true
---

## 1. 安装 [Homebrew](https://brew.sh/)

这一步会自动安装 xcode-select，包含了常用的开发工具。

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## 2. 安装常用应用

以下按需安装。

其它软件可在 [Homebrew](https://brew.sh/) 查找。

```sh
brew install --cask iterm2
brew install --cask google-chrome
brew install --cask visual-studio-code
brew install --cask jetbrains-toolbox
brew install --cask rectangle
brew install --cask plex
brew install --cask iina
brew install --cask qq
brew install --cask wechat
brew install --cask downie
brew install --cask topnotch
brew install --cask snipaste
brew install --cask docker
brew install --cask github
brew install --cask captin
brew install --cask notion
brew install --cask chatgpt
brew install --cask cursor
brew install --cask slack
brew install --cask claude
```

## 3. 安装 CLI 命令

按需安装。

```sh
brew install gh
brew install nvm
brew install tmux
brew install peco
brew install mysql
```

## 4. 安装 Oh My Zsh

macOS Catalina 之后默认使用 zsh，可直接安装 Oh My Zsh。

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

配置 Dotfiles

配置文件仓库：https://github.com/Amabel/dotfiles

用以下命令直接将仓库中的文件拷贝到 Home 目录下

```sh
curl --fail --silent --show-error --location https://codeload.github.com/Amabel/dotfiles/tar.gz/master | tar -x -C ~ --strip-components=1
```

## 5. 安装输入法

谷歌日语输入法：https://www.google.co.jp/ime/

搜狗输入法：https://pinyin.sogou.com/mac/

## 6. vscode 扩展

（或者通过 vscode 同步功能自动安装）

```sh
code --install-extension eamodio.gitlens
code --install-extension yzhang.markdown-all-in-one
code --install-extension github.vscode-pull-request-github
code --install-extension ms-vscode-remote.vscode-remote-extensionpack
code --install-extension vue.volar
code --install-extension esbenp.prettier-vscode
code --install-extension vscode-icons-team.vscode-icons
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension oderwat.indent-rainbow
code --install-extension mechatroner.rainbow-csv
code --install-extension mkxml.vscode-filesize
code --install-extension shardulm94.trailing-spaces
code --install-extension wakatime.vscode-wakatime
code --install-extension github.vscode-github-actions
code --install-extension formulahendry.auto-rename-tag
code --install-extension vincaslt.highlight-matching-tag
code --install-extension bradlc.vscode-tailwindcss
code --install-extension visualstudioexptteam.vscodeintellicode
code --install-extension codeium.codeium
code --install-extension amazonwebservices.aws-toolkit-vscode
```

## 7. 从 App Store 下载软件

- [iTab](https://apps.apple.com/cn/app/itab-show-switch-window/id6469623497?l=en-GB&mt=12)

- [iBar](https://apps.apple.com/cn/app/ibar-menubar-icon-control-tool/id6443843900?l=en-GB&mt=12)

- [iRightMouse](https://apps.apple.com/cn/app/irightmouse/id1497428978?l=en-GB&mt=12)

- [Better Menubar](https://apps.apple.com/cn/app/state-cpu-fan-memory-tem/id1472818562?l=en-GB&mt=12)
