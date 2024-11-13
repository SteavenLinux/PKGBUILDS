#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp PKGBUILD ~/ah
cp add-av_stream_get_first_dts-for-chromium.patch ~/ah
cp license_if_nonfree_enabled.txt ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/ffmpeg-obs*.pkg.tar.zst
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/ffmpeg-obs*.pkg.tar.zst.sig
cp ffmpeg-obs*.pkg.tar.zst /home/omarhanykasban/SteavenRepo/x86_64/
cp ffmpeg-obs*.pkg.tar.zst.sig /home/omarhanykasban/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Repo/ffmpeg-obs
