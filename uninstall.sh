#!/bin/bash

# exit when any command fails
set -e

/bin/bash ~/.oh-my-zsh/tools/uninstall.sh


brew list | xargs brew uninstall --force
brew list --cask | xargs brew uninstall --force

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)"

echo "[uninstall] Removing leftovers..."
rm -rf /usr/local/Homebrew/
rm -rf /usr/local/share/zsh*/
rm $HOME/.zsh*
rm $HOME/.fzf*
rm -rf $HOME/.zsh*/
rm -rf $HOME/.oh-my-zsh
rm -rf $HOME/.vscode
rm -rf $HOME/.fzf*/
rm -rf $HOME/.npm
rm -rf $HOME/Postman

