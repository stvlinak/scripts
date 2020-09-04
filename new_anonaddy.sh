#!/bin/bash

curl -sX POST \
    "https://app.anonaddy.com/api/v1/aliases" \
    -H "Content-Type: application/json" \
    -H "X-Requested-With: XMLHttpRequest" \
    -H "Authorization: Bearer $ANONADDY_TOKEN" \
    -d '{"domain":"anonaddy.me","description":"For example.com","format":"uuid"}' \
| jq -r .data.email \
| xclip -sel clip
