#!/bin/bash

# exit when any command fails
set -e

# This installs homebrew itself, and also the command line tools in silent mode
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "[main] Installing base tools..."
brew bundle --file base.Brewfile

echo "[main] Install dev dependencies?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) ./dev.sh; break;;
        No ) break;;
    esac
done

./macos.sh

cp .gitconfig $HOME

echo "[main] Loading terminal changes..."

source ~/.zshrc

echo "[main] done!"

echo "[main] Install App Store apps?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) brew bundle --file appstore.Brewfile; break;;
        No ) break;;
    esac
done