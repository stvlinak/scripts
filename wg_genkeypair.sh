#!/bin/bash

command -v wg >/dev/null 2>&1 || { echo >&2 "Wireguard is not installed."; exit 1; }

PAIRNAME=$1

if [ -z $PAIRNAME ]; then
    PAIRNAME="wg"
fi

wg genkey > "$PAIRNAME""_private.key" 
wg pubkey > "$PAIRNAME""_public.key" < "$PAIRNAME""_private.key"
