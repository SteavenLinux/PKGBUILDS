#!/bin/bash

# Ensure the directory exists
mkdir -p ~/ah

# Remove old copy and copy fresh sources
#rm -rf ~/ah/unigine-heaven
cp -r unigine-heaven ~/ah/unigine-heaven

# Move to build directory
cd ~/ah/unigine-heaven || exit 1

# Build and sign package
makepkg -sr --sign || exit 1

# Remove old package and signature from the repo
rm -f /home/omarhanykasban/SteavenRepo/x86_64/unigine-heaven*.pkg.tar.zst
rm -f /home/omarhanykasban/SteavenRepo/x86_64/unigine-heaven*.pkg.tar.zst.sig

# Copy new package and signature to the repo
cp unigine-heaven*.pkg.tar.zst /home/omarhanykasban/SteavenRepo/x86_64
cp unigine-heaven*.pkg.tar.zst.sig /home/omarhanykasban/SteavenRepo/x86_64

# Change to repo directory (optional, but doesn't execute anything)
cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/SteavenGamerYT
