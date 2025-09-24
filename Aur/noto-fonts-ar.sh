#!/bin/bash

# Ensure the directory exists
mkdir -p ~/ah

# Remove old copy and copy fresh sources
rm -rf ~/ah/noto-fonts-ar
cp -r noto-fonts-ar ~/ah/noto-fonts-ar

# Move to build directory
cd ~/ah/noto-fonts-ar || exit 1

# Build and sign package
makepkg -sr --sign || exit 1

# Remove old package and signature from the repo
rm -f /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64/noto-fonts-ar*.pkg.tar.zst
rm -f /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64/noto-fonts-ar*.pkg.tar.zst.sig

# Copy new package and signature to the repo
cp *.pkg.tar.zst /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64
cp *.pkg.tar.zst.sig /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64

# Change to repo directory (optional, but doesn't execute anything)
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Aur
