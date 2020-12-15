#!/bin/sh
set -e

# this if will check if the first argument is a flag
# but only works if all arguments require a hyphenated flag
# -v; -SL; -f arg; etc will work, but not arg1 arg2
if [ "$#" -eq 0 ] || [ "${1#-}" != "$1" ]; then
    set -- trivy "$@"
fi

# check for the expected command
if [ "$1" = 'trivy' ]; then
    # use gosu (or su-exec) to drop to a non-root user
    exec su-exec trivy "$@"
fi

# else default to run whatever the user wanted like "bash" or "sh"
exec "$@"