#!/bin/bash

# Ensure the directory exists
mkdir -p ~/ah

# Remove old copy and copy fresh sources
rm -rf ~/ah/udev-joystick-blacklist
cp -r udev-joystick-blacklist ~/ah/udev-joystick-blacklist

# Move to build directory
cd ~/ah/udev-joystick-blacklist || exit 1

# Build and sign package
makepkg -sr --sign || exit 1

# Remove old package and signature from the repo
rm -f /mnt/nvme/SteavenRepo/x86_64/udev-joystick-blacklist*.pkg.tar.zst
rm -f /mnt/nvme/SteavenRepo/x86_64/udev-joystick-blacklist*.pkg.tar.zst.sig

# Copy new package and signature to the repo
cp *.pkg.tar.zst /mnt/nvme/SteavenRepo/x86_64
cp *.pkg.tar.zst.sig /mnt/nvme/SteavenRepo/x86_64

# Change to repo directory (optional, but doesn't execute anything)
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Aur
