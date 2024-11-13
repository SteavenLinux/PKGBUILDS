#!/bin/bash
#rm -rf ~/ah
mkdir ~/ah
cp cachyos-proton/PKGBUILD ~/ah
cp cachyos-proton/nvapi-optical-flow.patch ~/ah
cp cachyos-proton/proton-cachyos.install ~/ah
cp cachyos-proton/proton-optical-flow.patch ~/ah
cp cachyos-proton/wine-optical-flow.patch ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/cachyos-proton*.pkg.tar.zst
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/cachyos-proton*.pkg.tar.zst.sig
cp cachyos-proton*.pkg.tar.zst /home/omarhanykasban/SteavenRepo/x86_64/
cp cachyos-proton*.pkg.tar.zst.sig /home/omarhanykasban/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Repo/Aur