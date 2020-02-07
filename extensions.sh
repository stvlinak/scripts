#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

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

    wget -qO /tmp/$EXTENSION_UUID.zip https://extensions.gnome.org/download-extension/$EXTENSION_UUID.shell-extension.zip?shell_version=$GDM_VERSION
    unzip -n /tmp/$EXTENSION_UUID.zip -d ~/.local/share/gnome-shell/extensions/$EXTENSION_UUID
    rm /tmp/$EXTENSION_UUID.zip
}

install_extensions