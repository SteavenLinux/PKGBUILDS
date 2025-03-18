#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp looking-glass-git/PKGBUILD ~/ah
cp looking-glass-git/looking-glass-git.install ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/looking-glass-git*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/looking-glass-git*.pkg.tar.zst.sig
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/obs-plugin-looking-glass-git*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/obs-plugin-looking-glass-git*.pkg.tar.zst.sig
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/looking-glass-host-git*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/looking-glass-host-git*.pkg.tar.zst.sig
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/looking-glass-module-dkms-git*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/looking-glass-module-dkms-git*.pkg.tar.zst.sig
cp looking-glass-git*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp looking-glass-git*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp obs-plugin-looking-glass-git*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp obs-plugin-looking-glass-git*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp looking-glass-host-git*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp looking-glass-host-git*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp looking-glass-module-dkms-git*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp looking-glass-module-dkms-git*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo
git add .
git commit -m "Updated looking-glass-git obs-plugin-looking-glass-git looking-glass-host-git looking-glass-module-dkms-git"
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/GitHub/Aur