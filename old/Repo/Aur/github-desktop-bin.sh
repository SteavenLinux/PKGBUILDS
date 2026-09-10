#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp github-desktop-bin/PKGBUILD ~/ah
cp github-desktop-bin/github-desktop.desktop ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /mnt/hdd/SteavenRepo/x86_64/github-desktop-bin*.pkg.tar.zst
rm -rf /mnt/hdd/SteavenRepo/x86_64/github-desktop-bin*.pkg.tar.zst.sig
cp github-desktop-bin*.pkg.tar.zst /mnt/hdd/SteavenRepo/x86_64/
cp github-desktop-bin*.pkg.tar.zst.sig /mnt/hdd/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Repo/Aur