#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp duckstation-qt-bin/PKGBUILD ~/ah
cp duckstation-qt-bin/update.sh ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/duckstation-qt-bin*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/duckstation-qt-bin*.pkg.tar.zst.sig
cp duckstation-qt-bin*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp duckstation-qt-bin*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo
git add .
git commit -m "Updated duckstation-qt-bin"
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/GitHub/Aur