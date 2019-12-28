#!/bin/bash

cd /tmp

wget https://github.com/stigvoss/scripts/blob/master/assets/master_branch_multi_account_containers-6.2.0-fx.xpi ./Downloads/custom_containers_build.xpi

wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
sudo add-apt-repository 'deb https://typora.io/linux ./'

wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

sudo add-apt-repository universe

sudo apt install -y apt-transport-https

sudo apt update

sudo snap install signal-desktop telegram-desktop
sudo snap install --classic code
sudo snap remove gnome-calculator gnome-system-monitor gnome-characters

sudo apt install -y gnome-calculator gnome-system-monitor gnome-characters keepass2 libreoffice virtualbox kolourpaint gnome-tweaks gnome-calendar compizconfig-settings-manager gnome-photos nextcloud-desktop xdotool yubikey-personalization-gui typora remmina curl openssh-server virtualbox-guest-additions-iso virtualbox-ext-pack dotnet-sdk-3.0 powershell git vlc net-tools

sudo modprobe vboxdrv

wget https://dl.discordapp.net/apps/linux/0.0.9/discord-0.0.9.deb
sudo dpkg -i discord-0.0.9.deb

wget https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb
sudo dpkg -i viber.deb

wget https://bitbucket.org/devinmartin/keeotp/downloads/KeeOtp-1.3.9.zip
unzip KeeOtp-1.3.9.zip
sudo mv ./dlls/* /usr/lib/keepass2/Plugins/

wget https://github.com/brush701/keechallenge/releases/download/1.5/KeeChallenge_1.5.zip
unzip KeeChallenge_1.5.zip
sudo mv ./KeeChallenge_1.5/64bit/* /usr/lib/keepass2/Plugins/
sudo mv ./KeeChallenge_1.5/* /usr/lib/keepass2/Plugins/

wget https://github.com/troennes/quartz-theme-typora/archive/master.zip
unzip master.zip

cp ./quartz-theme-typora-master/theme/*  ~/.config/Typora/themes/

curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
sudo apt install -y ./keybase_amd64.deb
run_keybase

https://github.com/stigvoss/scripts/blob/master/assets/tresorit_installer.run
sh tresorit_installer.run

mkdir ~/.local/bin

wget https://raw.githubusercontent.com/stigvoss/scripts/master/saltpack-gist.sh
https://raw.githubusercontent.com/stigvoss/scripts/master/new_address.sh

mv saltpack-gist.sh ~/.local/bin
mv new_address.sh ~/.local/bin

read -p "Catch all domain name: " CATCHALL_DOMAIN

echo $CATCHALL_DOMAIN >> ~/.profile
