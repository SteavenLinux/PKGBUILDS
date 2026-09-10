#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp PKGBUILD ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /mnt/hdd/SteavenRepo/x86_64/mcpelauncher-appimage-cracked*.pkg.tar.zst
rm -rf /mnt/hdd/SteavenRepo/x86_64/mcpelauncher-appimage-cracked*.pkg.tar.zst.sig
cp mcpelauncher-appimage-cracked*.pkg.tar.zst /mnt/hdd/SteavenRepo/x86_64/
cp mcpelauncher-appimage-cracked*.pkg.tar.zst.sig /mnt/hdd/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Repo/mcpelauncher-appimage-cracked
