#!/bin/bash
set -e

# Set WebAdmin credentials
# if [ ! -f /usr/local/lsws/admin/conf/htpasswd ]; then
    echo "Setting up WebAdmin credentials..."
    /usr/local/lsws/admin/misc/admpass.sh <<EOF
${WEBADMIN_USER}
${WEBADMIN_PASS}
${WEBADMIN_PASS}
EOF
# fi

# Ensure correct permissions for logs
chown -R www-data:www-data /usr/local/lsws/logs

# Start OpenLiteSpeed
/usr/local/lsws/bin/lswsctrl start

# Keep container running
tail -f /dev/null
