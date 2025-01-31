#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp sunshine/PKGBUILD ~/ah
cp sunshine/sunshine.install ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/sunshine*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/sunshine*.pkg.tar.zst.sig
cp sunshine*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp sunshine*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo
git add .
git commit -m "Updated sunshine"
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/GitHub/Aur
