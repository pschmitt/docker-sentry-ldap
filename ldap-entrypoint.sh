#!/usr/bin/env bash

CONFIG_FILE="${SENTRY_CONF}/sentry.conf.py"

if ! grep -q "split_settings.tools" "$CONFIG_FILE"
then
cat << EOF >> "$CONFIG_FILE"
from split_settings.tools import optional, include
include(
    optional('/config/ldap.conf.py')
)
EOF
fi

exec /entrypoint.sh "$@"
