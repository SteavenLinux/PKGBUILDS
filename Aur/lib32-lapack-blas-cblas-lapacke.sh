#!/bin/bash

# Ensure the directory exists
mkdir -p ~/ah

# Remove old copy and copy fresh sources
rm -rf ~/ah/lib32-lapack-blas-cblas-lapacke
cp -r lib32-lapack-blas-cblas-lapacke ~/ah/lib32-lapack-blas-cblas-lapacke

# Move to build directory
cd ~/ah/lib32-lapack-blas-cblas-lapacke || exit 1

# Build and sign package
makepkg -sr --sign || exit 1

# Remove old package and signature from the repo
rm -f /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64/lib32-lapack*.pkg.tar.zst
rm -f /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64/lib32-lapack*.pkg.tar.zst.sig
rm -f /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64/lib32-blas*.pkg.tar.zst
rm -f /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64/lib32-blas*.pkg.tar.zst.sig
rm -f /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64/lib32-cblas*.pkg.tar.zst
rm -f /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64/lib32-cblas*.pkg.tar.zst.sig
rm -f /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64/lib32-lapacke*.pkg.tar.zst
rm -f /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64/lib32-lapacke*.pkg.tar.zst.sig

# Copy new package and signature to the repo
cp *.pkg.tar.zst /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64
cp *.pkg.tar.zst.sig /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64

# Change to repo directory (optional, but doesn't execute anything)
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Aur
