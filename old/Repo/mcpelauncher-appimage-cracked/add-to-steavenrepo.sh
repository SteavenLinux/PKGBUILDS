#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp PKGBUILD ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64/mcpelauncher-appimage-cracked*.pkg.tar.zst
rm -rf /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64/mcpelauncher-appimage-cracked*.pkg.tar.zst.sig
cp mcpelauncher-appimage-cracked*.pkg.tar.zst /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64/
cp mcpelauncher-appimage-cracked*.pkg.tar.zst.sig /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Repo/mcpelauncher-appimage-cracked
