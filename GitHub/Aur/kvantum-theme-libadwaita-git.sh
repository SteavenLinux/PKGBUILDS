#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp kvantum-theme-libadwaita-git/PKGBUILD ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/kvantum-theme-libadwaita-git*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/kvantum-theme-libadwaita-git*.pkg.tar.zst.sig
cp kvantum-theme-libadwaita-git*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp kvantum-theme-libadwaita-git*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo
git add .
git commit -m "Updated kvantum-theme-libadwaita-git"
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/GitHub/Aur