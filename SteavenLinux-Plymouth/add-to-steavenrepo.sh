#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp PKGBUILD ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenRepo/x86_64/SteavenLinux-plymouth-theme*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenRepo/x86_64/SteavenLinux-plymouth-theme*.pkg.tar.zst.sig
cp SteavenLinux-plymouth-theme*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenRepo/x86_64/
cp SteavenLinux-plymouth-theme*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenRepo
git add .
git commit -m "Updated SteavenLinux-plymouth-theme"
cd /home/omarhanykasban/GitHub/PKGBUILDS/SteavenLinux-plymouth-theme