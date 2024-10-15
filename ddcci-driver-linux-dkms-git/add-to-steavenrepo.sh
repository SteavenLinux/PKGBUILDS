#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp PKGBUILD ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenRepo/x86_64/ddcci-driver-linux-dkms-git*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenRepo/x86_64/ddcci-driver-linux-dkms-git*.pkg.tar.zst.sig
cp ddcci-driver-linux-dkms-git*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenRepo/x86_64/
cp ddcci-driver-linux-dkms-git*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenRepo
git add .
git commit -m "Updated ddcci-driver-linux-dkms-git"
cd /home/omarhanykasban/GitHub/PKGBUILDS/ddcci-driver-linux-dkms-git