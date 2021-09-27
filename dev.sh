#!/bin/bash

# exit when any command fails
set -e

echo "[dev] installing dev dependencies..."

## oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo "ZSH_DISABLE_COMPFIX=true\n$(cat ~/.zshrc)" > ~/.zshrc

brew bundle --file dev.Brewfile

$(brew --prefix)/opt/fzf/install

echo "source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
echo "source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

sed -i "" 's/ZSH_THEME="robbyrussell"/# ZSH_THEME="robbyrussell"/g' ~/.zshrc
sed -i "" 's/plugins=(git)/plugins=(git docker docker-compose aws fzf)/g' ~/.zshrc

cp /System/Applications/Utilities/Terminal.app/Contents/Resources/Fonts/*.otf ~/Library/Fonts/

cp .gitconfig $HOME

# Set Visual Studio Code as preferred text editor
gh config set editor "code -w"

echo 'alias lle="exa --long --header --git --icons"' >> ~/.zshrc

npm install -g spaceship-zsh-theme
echo 'SPACESHIP_BATTERY_SHOW="false"' >> ~/.zshrc
echo 'SPACESHIP_EXIT_CODE_SHOW="true"' >> ~/.zshrc

# setup dev env
DEV_PATH=$HOME/workspace
mkdir -p $DEV_PATH
echo "[dev] created default workspace at $DEV_PATH"

sudo xcode-select --install && sleep 1
osascript -e 'tell application "System Events"' -e 'tell process "Install Command Line Developer Tools"' -e 'keystroke return' -e 'click button "Agree" of window "License Agreement"' -e 'end tell' -e 'end tell'

