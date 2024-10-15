#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp PKGBUILD ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenRepo/x86_64/SteavenLinux-gnome-meta*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenRepo/x86_64/SteavenLinux-gnome-meta*.pkg.tar.zst.sig
cp SteavenLinux-gnome-meta*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenRepo/x86_64/
cp SteavenLinux-gnome-meta*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenRepo
git add .
git commit -m "Updated SteavenLinux-gnome-meta"
cd /home/omarhanykasban/GitHub/PKGBUILDS/SteavenLinux-gnome-meta