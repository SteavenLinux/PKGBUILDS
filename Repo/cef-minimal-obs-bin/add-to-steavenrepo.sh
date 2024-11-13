#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp PKGBUILD ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/cef-minimal-obs-bin*.pkg.tar.zst
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/cef-minimal-obs-bin*.pkg.tar.zst.sig
cp cef-minimal-obs-bin*.pkg.tar.zst /home/omarhanykasban/SteavenRepo/x86_64/
cp cef-minimal-obs-bin*.pkg.tar.zst.sig /home/omarhanykasban/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Repo/cef-minimal-obs-bin
