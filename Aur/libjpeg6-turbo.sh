#!/bin/bash

# Ensure the directory exists
mkdir -p ~/ah

# Remove old copy and copy fresh sources
rm -rf ~/ah/libjpeg6-turbo
cp -r libjpeg6-turbo ~/ah/libjpeg6-turbo

# Move to build directory
cd ~/ah/libjpeg6-turbo || exit 1

# Build and sign package
makepkg -sr --sign || exit 1

# Remove old package and signature from the repo
rm -f /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64/libjpeg6-turbo*.pkg.tar.zst
rm -f /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64/libjpeg6-turbo*.pkg.tar.zst.sig

# Copy new package and signature to the repo
cp *.pkg.tar.zst /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64
cp *.pkg.tar.zst.sig /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64

# Change to repo directory (optional, but doesn't execute anything)
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Aur
