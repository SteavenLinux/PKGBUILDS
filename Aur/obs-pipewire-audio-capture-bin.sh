#!/bin/bash

# Ensure the directory exists
mkdir -p ~/ah

# Remove old copy and copy fresh sources
rm -rf ~/ah/obs-pipewire-audio-capture-bin
cp -r obs-pipewire-audio-capture-bin ~/ah/obs-pipewire-audio-capture-bin

# Move to build directory
cd ~/ah/obs-pipewire-audio-capture-bin || exit 1

# Build and sign package
makepkg -sr --sign || exit 1

# Remove old package and signature from the repo
rm -f /mnt/hdd/SteavenRepo/x86_64/obs-pipewire-audio-capture-bin*.pkg.tar.zst
rm -f /mnt/hdd/SteavenRepo/x86_64/obs-pipewire-audio-capture-bin*.pkg.tar.zst.sig

# Copy new package and signature to the repo
cp *.pkg.tar.zst /mnt/hdd/SteavenRepo/x86_64
cp *.pkg.tar.zst.sig /mnt/hdd/SteavenRepo/x86_64

# Change to repo directory (optional, but doesn't execute anything)
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Aur
