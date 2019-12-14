#!/bin/bash

RECIPIENT=$1
MESSAGE=$2

USERNAME=stigvoss
PASSWORD=$(cat ghpasswd)

if [ -z "$RECIPIENT" ]; then
    echo "Recipient is not set."
    exit 1
fi

if [ -z "$MESSAGE" ]; then
    echo "Message is not set"
    exit 1
fi

SALTPACK=$(echo $MESSAGE | keybase encrypt $RECIPIENT)

TIMESTAMP=$(date +%s)

PAYLOAD='{ "description": "A saltpack for '"$RECIPIENT"'", "public": false, "files": { "'"$RECIPIENT-$TIMESTAMP"'.saltpack": { "content": "'"$SALTPACK"'" } } }'

RESPONSE=$(curl -u "$USERNAME:$PASSWORD" -sS -H "Content-Type: application/json" -d "$(echo $PAYLOAD)" https://api.github.com/gists)

RAW_URL=$(echo $RESPONSE | jq -r .files[].raw_url)

echo $RAW_URL
