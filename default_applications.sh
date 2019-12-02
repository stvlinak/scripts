#!/bin/bash

cd /tmp

wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
sudo add-apt-repository 'deb https://typora.io/linux ./'

wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

sudo add-apt-repository universe

sudo apt install -y apt-transport-https

sudo apt update

sudo apt install -y keepass2 libreoffice virtualbox kolourpaint gnome-tweaks gnome-calendar compizconfig-settings-manager gnome-photos nextcloud-desktop xdotool yubikey-personalization-gui typora remmina curl openssh-server virtualbox-guest-additions-iso virtualbox-ext-pack dotnet-sdk-3.0 powershell git vlc net-tools

sudo modprobe vboxdrv

sudo snap install signal-desktop telegram-desktop discord viber-unofficial
sudo snap install --classic code

wget https://bitbucket.org/devinmartin/keeotp/downloads/KeeOtp-1.3.9.zip
unzip KeeOtp-1.3.9.zip
sudo mv ./dlls/* /usr/lib/keepass2/Plugins/

wget https://github.com/brush701/keechallenge/releases/download/1.5/KeeChallenge_1.5.zip
unzip KeeChallenge_1.5.zip
sudo mv ./KeeChallenge_1.5/64bit/* /usr/lib/keepass2/Plugins/
sudo mv ./KeeChallenge_1.5/* /usr/lib/keepass2/Plugins/

wget https://github.com/troennes/quartz-theme-typora/archive/master.zip
unzip master.zip

# TODO: Install Quartz themes in Typora.

curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
sudo apt install -y ./keybase_amd64.deb
run_keybase


