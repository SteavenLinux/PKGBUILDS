#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp freedownloadmanager/PKGBUILD ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/*freedownloadmanager*.pkg.tar.zst
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/*freedownloadmanager*.pkg.tar.zst.sig
cp *freedownloadmanager*.pkg.tar.zst /home/omarhanykasban/SteavenRepo/x86_64/
cp *freedownloadmanager*.pkg.tar.zst.sig /home/omarhanykasban/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Repo/Aur