#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp PKGBUILD ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /mnt/nvme/SteavenRepo/x86_64/mcpelauncher-appimage-cracked*.pkg.tar.zst
rm -rf /mnt/nvme/SteavenRepo/x86_64/mcpelauncher-appimage-cracked*.pkg.tar.zst.sig
cp mcpelauncher-appimage-cracked*.pkg.tar.zst /mnt/nvme/SteavenRepo/x86_64/
cp mcpelauncher-appimage-cracked*.pkg.tar.zst.sig /mnt/nvme/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Repo/mcpelauncher-appimage-cracked
