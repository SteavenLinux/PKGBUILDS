#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp cachyos-proton/PKGBUILD ~/ah
cp cachyos-proton/proton-cachyos.install ~/ah
cp cachyos-proton/879f09d2ac799cca99b78de3442194ebbe29d24a.patch ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /mnt/Omar-Old-PC/home/omarhanykasban/SteavenRepo/x86_64/cachyos-proton*.pkg.tar.zst
rm -rf /mnt/Omar-Old-PC/home/omarhanykasban/SteavenRepo/x86_64/cachyos-proton*.pkg.tar.zst.sig
cp cachyos-proton*.pkg.tar.zst /mnt/Omar-Old-PC/home/omarhanykasban/SteavenRepo/x86_64/
cp cachyos-proton*.pkg.tar.zst.sig /mnt/Omar-Old-PC/home/omarhanykasban/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Repo/Aur
