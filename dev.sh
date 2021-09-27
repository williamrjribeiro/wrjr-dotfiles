#!/bin/bash

# exit when any command fails
set -e

echo "[dev] installing dev dependencies..."

## oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo "ZSH_DISABLE_COMPFIX=true\n$(cat ~/.zshrc)" > ~/.zshrc

## install a bunch of dev dependencies using BREW
brew bundle --file dev.Brewfile

$(brew --prefix)/opt/fzf/install

# Easy NVM install https://github.com/lukechilds/zsh-nvm
git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm

## install Yarn with NPM AFTER NVM so the Node versions match
npm i -g yarn

## Change THEME
sed -i "" 's/ZSH_THEME="robbyrussell"/# ZSH_THEME="spaceship"/g' ~/.zshrc

## Add Plugins
sed -i "" 's/plugins=(git)/plugins=(git docker docker-compose aws fzf zsh-nvm)/g' ~/.zshrc

## Add more fonts to the system
cp /System/Applications/Utilities/Terminal.app/Contents/Resources/Fonts/*.otf ~/Library/Fonts/

cp .gitconfig $HOME

# Set Visual Studio Code as preferred text editor
gh config set editor "code -w"


echo "source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
echo "source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

echo 'alias lle="exa --long --header --git --icons"' >> ~/.zshrc

echo 'SPACESHIP_BATTERY_SHOW="false"' >> ~/.zshrc

# setup dev env
DEV_PATH=$HOME/workspace
mkdir -p $DEV_PATH
echo "[dev] created default workspace at $DEV_PATH"

sudo xcode-select --install && sleep 1
osascript -e 'tell application "System Events"' -e 'tell process "Install Command Line Developer Tools"' -e 'keystroke return' -e 'click button "Agree" of window "License Agreement"' -e 'end tell' -e 'end tell'
