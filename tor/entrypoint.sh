#!/bin/sh
set -o errexit

chmodf() { find $2 -type f -exec chmod -v $1 {} \;
}
chmodd() { find $2 -type d -exec chmod -v $1 {} \;
}

# fix permissions
chmodd 700 /var/lib/tor
chmodf 600 /var/lib/tor

exec "$@"
