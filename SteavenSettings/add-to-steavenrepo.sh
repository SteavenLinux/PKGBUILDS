#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp PKGBUILD ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenRepo/x86_64/steavensettings*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenRepo/x86_64/steavensettings*.pkg.tar.zst.sig
cp steavensettings*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenRepo/x86_64/
cp steavensettings*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenRepo
git add .
git commit -m "Updated steavensettings"
cd /home/omarhanykasban/GitHub/PKGBUILDS/steavensettings