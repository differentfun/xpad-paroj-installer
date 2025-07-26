#!/bin/bash

set -e

echo "==> Unloading the original xpad module..."
sudo rmmod xpad || echo "xpad not loaded, continuing..."

echo "==> Disabling the original xpad module to prevent it from loading..."
XPAD_PATH="/lib/modules/$(uname -r)/kernel/drivers/input/joystick/xpad.ko"
if [ -f "$XPAD_PATH" ]; then
    sudo mv "$XPAD_PATH" "${XPAD_PATH}.disabled"
else
    echo "xpad.ko not found — it may already be disabled."
fi

echo "==> Updating initramfs..."
sudo update-initramfs -u

echo "==> Installing required packages..."
sudo apt update
sudo apt install -y dkms git build-essential

echo "==> Cloning the patched xpad driver from GitHub..."
cd ~
git clone https://github.com/paroj/xpad.git || {
    echo "Repository already cloned, continuing..."
}

cd ~/xpad

echo "==> Building the xpad module..."
make

echo "==> Preparing DKMS source directory..."
sudo mkdir -p /usr/src/xpad-0.4
sudo cp -r ~/xpad/* /usr/src/xpad-0.4/

echo "==> Adding, building, and installing the module via DKMS..."
sudo dkms add -m xpad -v 0.4 || echo "Module already added."
sudo dkms build -m xpad -v 0.4
sudo dkms install -m xpad -v 0.4 --force

echo "==> Done! You can now load the module with: sudo modprobe xpad"
