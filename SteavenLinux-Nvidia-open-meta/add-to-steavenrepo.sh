#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp PKGBUILD ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/SteavenLinux-Nvidia-open-meta*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/SteavenLinux-Nvidia-open-meta*.pkg.tar.zst.sig
cp SteavenLinux-Nvidia-open-meta*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp SteavenLinux-Nvidia-open-meta*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo
git add .
git commit -m "Updated SteavenLinux-Nvidia-open-meta"
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/SteavenLinux-Nvidia-open-meta