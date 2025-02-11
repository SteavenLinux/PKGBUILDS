#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp PKGBUILD ~/ah
cp nvidia-sleep.conf ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/SteavenLinux-Nvidia-550xx-proprietary-meta*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/SteavenLinux-Nvidia-550xx-proprietary-meta*.pkg.tar.zst.sig
cp SteavenLinux-Nvidia-550xx-proprietary-meta*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp SteavenLinux-Nvidia-550xx-proprietary-meta*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo
git add .
git commit -m "Updated SteavenLinux-Nvidia-550xx-proprietary-meta"
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/GitHub/SteavenLinux-Nvidia-550xx-proprietary-meta
