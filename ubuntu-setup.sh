#!/bin/bash
set -e

# *** You need libgpg-error to build this program.
# **  This library is for example available at
# ***   https://gnupg.org/ftp/gcrypt/gpgrt
# *** (at least version 1.46 is required.)
# ***
# configure:
# ***
# *** You need libgcrypt to build this program.
# **  This library is for example available at
# ***   https://gnupg.org/ftp/gcrypt/libgcrypt/
# *** (at least version 1.9.1 (API 1) is required.)
# ***
# configure:
# ***
# *** You need libassuan to build this program.
# *** This library is for example available at
# ***   https://gnupg.org/ftp/gcrypt/libassuan/
# *** (at least version 2.5.0 (API 2) is required).
# ***
# configure:
# ***
# *** You need libksba to build this program.
# *** This library is for example available at
# ***   https://gnupg.org/ftp/gcrypt/libksba/
# *** (at least version 1.6.3 using API 1 is required).
# ***
# configure:
# ***
# *** It is now required to build with support for the
# *** New Portable Threads Library (nPth). Please install this
# *** library first.  The library is for example available at
# ***   https://gnupg.org/ftp/gcrypt/npth/

# install boring things we probably need
sudo apt update && sudo apt install -y build-essential nodejs npm unzip zip \
  fzf tmux pkg-config protobuf-compiler cmake linux-libc-dev clang git-secret \
  libksba-dev libassuan-dev libgpg-error-dev libgcrypt-dev libnpth-dev
sudo apt upgrade

# tmux alias, so we can use our config
echo "alias tmux='tmux -f ~/.config/tmux/tmux.conf'" >> ~/.bashrc

# install docker
# 1. add gpg key
sudo snap install docker

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# go
sudo snap install go --classic

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

# setup git
git config --global user.email "jamiepond259@gmail.com"
git config --global user.name "Jamie Pond"

rm -rf ~/jamie-config
git clone https://github.com/jamierpond/.config ~/jamie-config
cp -r ~/jamie-config/* ~/.config

# install nvims
sudo snap install nvim --classic

