#!/bin/bash

# Ensure the directory exists
mkdir -p ~/ah

# Remove old copy and copy fresh sources
rm -rf ~/ah/nvidia-utils-no-open
cp -r nvidia-utils-no-open ~/ah/nvidia-utils-no-open
cp ~/Downloads/NVIDIA-Linux-x86_64-570.133.07.run ~/ah/nvidia-utils-no-open

# Move to build directory
cd ~/ah/nvidia-utils-no-open || exit 1

# Build and sign package
makepkg -sr --sign || exit 1

# Remove old package and signature from the repo
rm -f /mnt/nvme/SteavenRepo/x86_64/nvidia-utils-no-open*.pkg.tar.zst
rm -f /mnt/nvme/SteavenRepo/x86_64/nvidia-utils-no-open*.pkg.tar.zst.sig

# Copy new package and signature to the repo
cp *.pkg.tar.zst /mnt/nvme/SteavenRepo/x86_64
cp *.pkg.tar.zst.sig /mnt/nvme/SteavenRepo/x86_64

# Change to repo directory (optional, but doesn't execute anything)
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/SteavenGamerYT

