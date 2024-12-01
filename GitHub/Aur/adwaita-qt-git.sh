#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp adwaita-qt-git/PKGBUILD ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/adwaita-qt*-git*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/adwaita-qt*-git*.pkg.tar.zst.sig
cp adwaita-qt*-git*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp adwaita-qt*-git*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo
git add .
git commit -m "Updated adwaita-qt-git"
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/GitHub/Aur