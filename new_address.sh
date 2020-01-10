ADDRESS=$(echo "$RANDOM$(date +%s)" | md5sum | cut -c -32)
echo "$ADDRESS@$CATCHALL_DOMAIN"
echo "$ADDRESS@$CATCHALL_DOMAIN" | xclip -sel clip
