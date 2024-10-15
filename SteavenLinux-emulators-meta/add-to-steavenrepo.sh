#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp PKGBUILD ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenRepo/x86_64/SteavenLinux-emulators-meta*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenRepo/x86_64/SteavenLinux-emulators-meta*.pkg.tar.zst.sig
cp SteavenLinux-emulators-meta*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenRepo/x86_64/
cp SteavenLinux-emulators-meta*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenRepo
git add .
git commit -m "Updated SteavenLinux-emulators-meta"
cd /home/omarhanykasban/GitHub/PKGBUILDS/SteavenLinux-emulators-meta