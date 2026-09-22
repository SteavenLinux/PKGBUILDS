#!/bin/bash

# Ensure the directory exists
mkdir -p ~/ah

# Remove old copy and copy fresh sources
rm -rf ~/ah/kvantum-theme-libadwaita-git
cp -r kvantum-theme-libadwaita-git ~/ah/kvantum-theme-libadwaita-git

# Move to build directory
cd ~/ah/kvantum-theme-libadwaita-git || exit 1

# Build and sign package
makepkg -sr --sign || exit 1

# Remove old package and signature from the repo
rm -f /mnt/hdd/SteavenRepo/x86_64/kvantum-theme-libadwaita-git*.pkg.tar.zst
rm -f /mnt/hdd/SteavenRepo/x86_64/kvantum-theme-libadwaita-git*.pkg.tar.zst.sig

# Copy new package and signature to the repo
cp *.pkg.tar.zst /mnt/hdd/SteavenRepo/x86_64
cp *.pkg.tar.zst.sig /mnt/hdd/SteavenRepo/x86_64

# Change to repo directory (optional, but doesn't execute anything)
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Aur
