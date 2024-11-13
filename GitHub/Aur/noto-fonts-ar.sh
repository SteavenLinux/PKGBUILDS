#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp noto-fonts-ar/PKGBUILD ~/ah
cp noto-fonts-ar/66-noto-ar.conf ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/noto-fonts-ar*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/noto-fonts-ar*.pkg.tar.zst.sig
cp noto-fonts-ar*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp noto-fonts-ar*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo
git add .
git commit -m "Updated noto-fonts-ar"
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/GitHub/Aur