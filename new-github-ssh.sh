#!/bin/bash

# exit when any command fails
set -e

echo "[new-github-ssh] Let's create a new SSH key for this computer..."

# TODO: what if there are already some SSH keys?
KEY_PATH=$HOME/.ssh/me_id_ed25519

ssh-keygen -t ed25519 -C "will@williamrjribeiro.com" -f $KEY_PATH

eval "$(ssh-agent -s)"

cp .ssh/config  ~/.ssh/config

# Use Apple's ssh-add tool so that we can store passphrase on Keychain
/usr/bin/ssh-add -K $KEY_PATH

# Verify that the new key has been added to the SSH agent
/usr/bin/ssh-add -l

pbcopy < $KEY_PATH.pub
echo "[new-github-ssh] public key copied to clipboard!"

echo "[new-github-ssh] done! ADD IT TO GITHUB: https://github.com/settings/keys"
