#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp PKGBUILD ~/ah
cp fastfetch ~/ah
cp steavenlinux.jsonc ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenRepo/x86_64/fastfetch*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenRepo/x86_64/fastfetch*.pkg.tar.zst.sig
cp fastfetch*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenRepo/x86_64/
cp fastfetch*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenRepo
git add .
git commit -m "Updated fastfetch"
cd /home/omarhanykasban/GitHub/PKGBUILDS/fastfetch