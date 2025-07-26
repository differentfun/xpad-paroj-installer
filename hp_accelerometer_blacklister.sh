#!/bin/bash

set -e

echo "==> Creating modprobe blacklist file for HP accelerometer modules..."

BLACKLIST_FILE="/etc/modprobe.d/blacklist-hp-accelerometer.conf"

# Use sudo to write to the file
sudo bash -c "cat > $BLACKLIST_FILE" <<EOF
# Disable HP accelerometer kernel modules to prevent conflicts or errors
blacklist hp_accel
blacklist lis3lv02d
EOF

echo "==> Blacklist file created at: $BLACKLIST_FILE"
echo "==> You may need to reboot for changes to take effect."
