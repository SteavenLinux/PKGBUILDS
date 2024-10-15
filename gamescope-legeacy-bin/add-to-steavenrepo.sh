#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp PKGBUILD ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenRepo/x86_64/gamescope-legacy-bin*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenRepo/x86_64/gamescope-legacy-bin*.pkg.tar.zst.sig
cp gamescope-legacy-bin*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenRepo/x86_64/
cp gamescope-legacy-bin*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenRepo
git add .
git commit -m "Updated gamescope-legacy-bin"
cd /home/omarhanykasban/GitHub/PKGBUILDS/gamescope-legacy-bin