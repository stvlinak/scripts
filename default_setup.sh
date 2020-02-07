#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

cd /tmp

install()
{
    init

    sudo apt update
    sudo apt upgrade

    add_typora_repo
    add_microsoft_repo
    add_signal_repo

    install_apt_packages

    replace_system_snap_packages
    install_snap_packages

    install_virtualbox

    install_vscode
    install_discord
    install_viber

    install_teamviewer

    install_keepass2_plugins
    install_typora_themes

    install_extensions

    install_tresorit
    install_keybase
    install_dotbash

    sudo apt autoremove -y
}

init()
{
    if [ "$EUID" -eq 0 ]; then
        echo "Please run unprivileged."
        exit
    fi

    . /etc/lsb-release
}

add_signal_repo()
{
    wget -qO - https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
    echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
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
    sudo snap install telegram-desktop

    if [[ $DISTRIB_RELEASE == "18.04" ]]; then
        sudo snap install communitheme
    fi
}

install_apt_packages()
{
    sudo apt update

    sudo apt install -y keepass2 \
        libreoffice \
        kolourpaint \
        gnome-tweaks \
        gnome-calendar \
        compizconfig-settings-manager \
        gnome-photos \
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
        xclip \
        debconf-utils \
        signal-desktop \
        htop
}

install_virtualbox()
{
    echo virtualbox-ext-pack virtualbox-ext-pack/license select true | sudo debconf-set-selections

    sudo apt install -y virtualbox \
        virtualbox-guest-additions-iso \
        virtualbox-ext-pack
    sudo modprobe vboxdrv
}

install_vscode()
{
    wget -O vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868
    sudo apt install -y ./vscode.deb
}

install_discord()
{
    wget https://dl.discordapp.net/apps/linux/0.0.9/discord-0.0.9.deb
    sudo apt install -y ./discord-0.0.9.deb
}

install_viber()
{
    wget https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb
    sudo apt install -y ./viber.deb
}

install_teamviewer()
{
    wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb -O teamviewer.deb
    sudo apt install -y ./teamviewer.deb
}

install_keybase()
{
    curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
    sudo apt install -y ./keybase_amd64.deb
    run_keybase
}

install_tresorit()
{
    wget https://github.com/stigvoss/scripts/blob/master/assets/tresorit_installer.run?raw=true -O tresorit_installer.run
    sh ./tresorit_installer.run
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
    if [[ ! -e ~/.config/Typora/themes/ ]]; then
        mkdir -p ~/.config/Typora/themes/
    fi

    wget https://github.com/troennes/quartz-theme-typora/archive/master.zip
    unzip master.zip

    mv ./quartz-theme-typora-master/theme/*  ~/.config/Typora/themes/
}

install_extensions() {
    if [[ -x "$(command -v gnome-shell)" ]]; then
        GDM_VERSION=$(gnome-shell --version)
        GDM_VERSION=${GDM_VERSION:12}

        EXTENSIONS=(
            "caffeine@patapon.info"
            "clock-override@gnomeshell.kryogenix.org"
            "dash-to-panel@jderose9.github.com"
            "freon@UshakovVasilii_Github.yahoo.com"
            "gsconnect@andyholmes.github.io"
            "lockkeys@vaina.lt"
            "noannoyance@sindex.com"
            "panel-osd@berend.de.schouwer.gmail.com"
            "sound-output-device-chooser@kgshank.net"
            "suspend-button@laserb"
            "tweaks-system-menu@extensions.gnome-shell.fifi.org"
            "unitylike-hotkey@webgyerek.net"
            "weatherintheclock@JasonLG1979.github.io"
        )

        for extension_uuid in ${EXTENSIONS[@]}; do
            install_gnome_extension $extension_uuid
        done
    fi    
}

install_gnome_extension()
{
    EXTENSION_UUID=$1

    mkdir -p ~/.local/share/gnome-shell/extensions/$EXTENSION_UUID

    wget -qO /tmp/$EXTENSION_UUID.zip https://extensions.gnome.org/download-extension/$EXTENSION_UUID.shell-extension.zip?shell_version=$GDM_VERSION
    unzip -n /tmp/$EXTENSION_UUID.zip -d ~/.local/share/gnome-shell/extensions/$EXTENSION_UUID
    rm /tmp/$EXTENSION_UUID.zip
}

install_dotbash()
{
    # TODO: Download and install dotbash from Git.

    # bash <(curl -s https://dotbash.stigvoss.dk/install.sh)

    echo "Install dotbash"
}

install
