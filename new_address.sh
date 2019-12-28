$CATCHALL_DOMAIN=

ADDRESS=$(echo "$RANDOM$(date +%s)" | md5sum | cut -c -32)
echo "$ADDRESS@$CATCHALL_DOMAIN"
