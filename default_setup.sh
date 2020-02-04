#!/bin/bash

set -e

cd /tmp


install()
{
    set_catchall_domain

    add_nextcloud_repo
    add_typora_repo
    add_microsoft_repo

    replace_system_snap_packages

    install_snap_packages
    install_apt_packages

    install_virtualbox

    install_vscode
    install_discord
    install_viber
    install_keybase

    install_keepass2_plugins
    install_typora_themes

    install_dotbash
}

set_catchall_domain()
{
    read -p "Catch all domain name: " CATCHALL_DOMAIN
    echo "export CATCHALL_DOMAIN=$CATCHALL_DOMAIN" >> ~/.profile
}

add_nextcloud_repo()
{
    sudo add-apt-repository ppa:nextcloud-devs/client
}

add_typora_repo()
{
    wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
    sudo add-apt-repository 'deb https://typora.io/linux ./'
}

add_microsoft_repo()
{
    wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb

    sudo add-apt-repository universe

    sudo apt install -y apt-transport-https

    sudo apt update
}

replace_system_snap_packages()
{
    sudo snap remove gnome-calculator \
        gnome-system-monitor \
        gnome-characters
    sudo apt install -y gnome-calculator \
        gnome-system-monitor \
        gnome-characters
}

install_snap_packages()
{
    sudo snap install signal-desktop \
        telegram-desktop
}

install_apt_packages()
{
    sudo apt install -y keepass2 \
        libreoffice \
        kolourpaint \
        gnome-tweaks \
        gnome-calendar \
        compizconfig-settings-manager \
        gnome-photos \
        nextcloud-desktop \
        xdotool \
        yubikey-personalization-gui \
        typora \
        remmina \
        curl \
        openssh-server \
        dotnet-sdk-3.0 \
        powershell \
        git \
        net-tools \
        xclip
}

install_virtualbox()
{
    sudo apt install -y virtualbox \
        virtualbox-guest-additions-iso \
        virtualbox-ext-pack
    sudo modprobe vboxdrv
}

install_vscode()
{
    wget -O vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868
    sudo apt install -y vscode.deb
}

install_discord()
{
    wget https://dl.discordapp.net/apps/linux/0.0.9/discord-0.0.9.deb
    sudo dpkg -i discord-0.0.9.deb
}

install_viber()
{
    wget https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb
    sudo dpkg -i viber.deb
}

install_keybase()
{
    curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
    sudo apt install -y ./keybase_amd64.deb
    run_keybase
}

install_tresorit()
{
    wget https://github.com/stigvoss/scripts/blob/master/assets/tresorit_installer.run
    sh tresorit_installer.run
}

install_keepass2_plugins()
{
    install_keyotp_plugin
    install_keechallenge_plugin
}

install_keyotp_plugin()
{
    wget https://bitbucket.org/devinmartin/keeotp/downloads/KeeOtp-1.3.9.zip
    unzip KeeOtp-1.3.9.zip
    sudo mv ./dlls/* /usr/lib/keepass2/Plugins/
}

install_keechallenge_plugin()
{
    wget https://github.com/brush701/keechallenge/releases/download/1.5/KeeChallenge_1.5.zip
    unzip KeeChallenge_1.5.zip
    sudo mv ./KeeChallenge_1.5/64bit/* /usr/lib/keepass2/Plugins/
    sudo mv ./KeeChallenge_1.5/* /usr/lib/keepass2/Plugins/
}

install_typora_themes()
{
    wget https://github.com/troennes/quartz-theme-typora/archive/master.zip
    unzip master.zip

    cp ./quartz-theme-typora-master/theme/*  ~/.config/Typora/themes/
}

install_dotbash()
{
    # TODO: Download and install dotbash from Git.

    # bash <(curl -s https://dotbash.stigvoss.dk/install.sh)

    echo "Install dotbash"
}

install
