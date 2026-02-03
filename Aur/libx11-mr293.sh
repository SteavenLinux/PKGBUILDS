#!/bin/bash

# Ensure the directory exists
mkdir -p ~/ah

# Remove old copy and copy fresh sources
rm -rf ~/ah/libx11-mr293
cp -r libx11-mr293 ~/ah/libx11-mr293

# Move to build directory
cd ~/ah/libx11-mr293 || exit 1

# Build and sign package
makepkg -sr --sign || exit 1

# Remove old package and signature from the repo
rm -f /mnt/Omar-Old-PC/home/omarhanykasban/SteavenRepo/x86_64/libx11-mr293*.pkg.tar.zst
rm -f /mnt/Omar-Old-PC/home/omarhanykasban/SteavenRepo/x86_64/libx11-mr293*.pkg.tar.zst.sig

# Copy new package and signature to the repo
cp *.pkg.tar.zst /mnt/Omar-Old-PC/home/omarhanykasban/SteavenRepo/x86_64
cp *.pkg.tar.zst.sig /mnt/Omar-Old-PC/home/omarhanykasban/SteavenRepo/x86_64

# Change to repo directory (optional, but doesn't execute anything)
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Aur
