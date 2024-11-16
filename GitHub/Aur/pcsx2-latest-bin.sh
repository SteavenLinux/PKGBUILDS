#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp pcsx2-latest-bin/PKGBUILD ~/ah
cp pcsx2-latest-bin/pcsx2.install ~/ah
cp pcsx2-latest-bin/.nvchecker.toml ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/pcsx2-latest-bin*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/pcsx2-latest-bin*.pkg.tar.zst.sig
cp pcsx2-latest-bin*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp pcsx2-latest-bin*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo
git add .
git commit -m "Updated pcsx2-latest-bin"
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/GitHub/Aur