#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp Ryujinx/PKGBUILD ~/ah
cp Ryujinx/PKGBUILD.common ~/ah
cp Ryujinx/PKGBUILD.release ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/ryujinx*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/ryujinx*.pkg.tar.zst.sig
cp ryujinx*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp ryujinx*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo
git add .
git commit -m "Updated ryujinx"
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/GitHub/Aur
