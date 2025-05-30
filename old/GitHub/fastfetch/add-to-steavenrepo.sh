#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp PKGBUILD ~/ah
cp fastfetch ~/ah
cp steavenlinux.jsonc ~/ah
cp steavenlinux-kitty.jsonc ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/fastfetch*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/fastfetch*.pkg.tar.zst.sig
cp fastfetch*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp fastfetch*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo
git add .
git commit -m "Updated fastfetch"
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/GitHub/fastfetch
