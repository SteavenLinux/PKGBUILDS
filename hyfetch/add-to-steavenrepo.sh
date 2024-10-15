#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp PKGBUILD ~/ah
cp config.conf ~/ah
cp steaven.txt ~/ah
cp neofetch ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenRepo/x86_64/hyfetch*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenRepo/x86_64/hyfetch*.pkg.tar.zst.sig
cp hyfetch*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenRepo/x86_64/
cp hyfetch*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenRepo
git add .
git commit -m "Updated hyfetch"
cd /home/omarhanykasban/GitHub/PKGBUILDS/hyfetch