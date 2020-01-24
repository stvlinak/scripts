ADDRESS=$(head -c 128 /dev/urandom | md5sum | cut -c -32)
notify-send "New random address in clipboard."
echo "$ADDRESS@$CATCHALL_DOMAIN" | xclip -sel clip
