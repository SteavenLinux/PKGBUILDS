#!/bin/bash

# Ensure the directory exists
mkdir -p ~/ah

# Remove old copy and copy fresh sources
rm -rf ~/ah/lib32-gstreamer
cp -r lib32-gstreamer ~/ah/lib32-gstreamer

# Move to build directory
cd ~/ah/lib32-gstreamer || exit 1

# Build and sign package
makepkg -sr --sign || exit 1

# Remove old package and signature from the repo
rm -f /mnt/Omar-PC-Server/home/omarhanykasban/SteavenRepo/x86_64/lib32-gstreamer*.pkg.tar.zst
rm -f /mnt/Omar-PC-Server/home/omarhanykasban/SteavenRepo/x86_64/lib32-gstreamer*.pkg.tar.zst.sig
rm -f /mnt/Omar-PC-Server/home/omarhanykasban/SteavenRepo/x86_64/lib32-gst-plugins-base-libs*.pkg.tar.zst
rm -f /mnt/Omar-PC-Server/home/omarhanykasban/SteavenRepo/x86_64/lib32-gst-plugins-base-libs*.pkg.tar.zst.sig
rm -f /mnt/Omar-PC-Server/home/omarhanykasban/SteavenRepo/x86_64/lib32-gst-plugins-base*.pkg.tar.zst
rm -f /mnt/Omar-PC-Server/home/omarhanykasban/SteavenRepo/x86_64/lib32-gst-plugins-base*.pkg.tar.zst.sig
rm -f /mnt/Omar-PC-Server/home/omarhanykasban/SteavenRepo/x86_64/lib32-gst-plugins-good*.pkg.tar.zst
rm -f /mnt/Omar-PC-Server/home/omarhanykasban/SteavenRepo/x86_64/lib32-gst-plugins-good*.pkg.tar.zst.sig

# Copy new package and signature to the repo
cp *.pkg.tar.zst /mnt/Omar-PC-Server/home/omarhanykasban/SteavenRepo/x86_64
cp *.pkg.tar.zst.sig /mnt/Omar-PC-Server/home/omarhanykasban/SteavenRepo/x86_64

# Change to repo directory (optional, but doesn't execute anything)
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Aur
