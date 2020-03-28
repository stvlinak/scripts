#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

cd /tmp

sudo mkdir -p /mnt/setup-items

sudo cryptsetup luksOpen setup-items.luks setup-items
sudo mount /dev/mapper/setup-items /mnt/setup-items

gedit --new-window /mnt/setup-items/passwords.txt &

sleep 0.5s

sudo umount /mnt/setup-items
sudo cryptsetup luksClose setup-items

sudo rm -R /mnt/setup-items