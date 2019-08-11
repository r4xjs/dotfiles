#!/bin/bash

# For better security do: `sudo visudo`
# and add: %sudo ALL=(ALL) NOPASSWD: ALL

# tools
sudo apt update -y && sudo apt upgrade -y
packages="zsh git vim tmux python python3 ipython ipython3 \
python-matplotlib build-essential nginx irssi curl wget nmap \
python-pip python3-pip"
sudo apt install -y $packages
sudo pip install pwntools

# dotfiles
if [ ! -d ~/git ]; then
    mkdir ~/git 
fi
cd ~/git
if [ ! -d ~/git/dotfiles ]; then
    git clone https://github.com/r4xjs/dotfiles
fi
cd dotfiles
git pull
./install.sh
cd ~/

# ssh
if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh
fi
sudo chown user:user ~/.ssh
chmod -R 700 ~/.ssh
if [ ! -f ~/.ssh/authorized_keys ]; then
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsIC3GW8TZ/EqUFGEphjUSokgHCaGv5KMwNklA36vdMV3EuXYWxu/RY3O8r/gj/eEAFeux/LIi+R2ZrvQmVIqC1l+gKPC8KgY63mNfRCGnRBiEfs3+j1Hv6a/z6Ss5hVSnKErDl/1jFcusTTWt9uObuD+Fya59DUiBzljK33wZyhgOTQ2ifLyHz7KNC+ysB4VZFr7zGQRi6QzZy2DT9TmXYmXjd03Bcne6eUnmZrTsWsDuoq84gPlPBo+KAMeO0fR05RjvG9XFCttdn93jpBg7/QwV83dza3xpp5oWJr60XdG1LD6b5iDgV41HJDQv+Q9kDRW1LPe8+qURrDX9WQfn user@home" >> ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/authorized_keys
fi

# directories
mkdir ~/irclogs
mkdir ~/ctf
