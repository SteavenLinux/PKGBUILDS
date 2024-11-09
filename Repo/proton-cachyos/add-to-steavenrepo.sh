#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp PKGBUILD ~/ah
cp nvapi-optical-flow.patch ~/ah
cp proton-cachyos.install ~/ah
cp proton-optical-flow.patch ~/ah
cp wine-optical-flow.patch ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/proton-cachyos*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/proton-cachyos*.pkg.tar.zst.sig
cp proton-cachyos*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp proton-cachyos*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo
git add .
git commit -m "Updated proton-cachyos"
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/proton-cachyos
