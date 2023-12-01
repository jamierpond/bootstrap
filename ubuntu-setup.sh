#!/bin/bash

# install boring things we probably need
sudo apt update && sudo apt install -y build-essential nodejs npm unzip zip fzf

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# go
sudo snap install go --classic


# setup git
git config --global user.email "jamiepond259@gmail.com"
git config --global user.name "Jamie Pond"

# install docker
# 1. add gpg key
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
# 2. do the install
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

rm -rf ~/jamie-config
git clone https://github.com/jamierpond/.config ~/jamie-config
cp -r ~/jamie-config/* ~/.config

# install nvims
sudo snap install nvim --classic

# todo just make this using a token
# install gh cli
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y

# login to gh
gh auth login
gh auth setup-git

