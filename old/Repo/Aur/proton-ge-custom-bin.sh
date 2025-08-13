#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp proton-ge-custom-bin/PKGBUILD ~/ah
cp proton-ge-custom-bin/user_settings.py ~/ah
cp proton-ge-custom-bin/launcher.sh ~/ah
cp proton-ge-custom-bin/pam_limits.conf ~/ah
cp proton-ge-custom-bin/pleasenote.install ~/ah
cp proton-ge-custom-bin/changelog.md ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /mnt/hdd/SteavenRepo/x86_64/proton-ge-custom-bin*.pkg.tar.zst
rm -rf /mnt/hdd/SteavenRepo/x86_64/proton-ge-custom-bin*.pkg.tar.zst.sig
cp proton-ge-custom-bin*.pkg.tar.zst /mnt/hdd/SteavenRepo/x86_64/
cp proton-ge-custom-bin*.pkg.tar.zst.sig /mnt/hdd/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Repo/Aur