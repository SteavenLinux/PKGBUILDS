#!/bin/bash
export FFMPEG_OBS_FULL=on
#rm -rf ~/ah
mkdir ~/ah
cp ffmpeg-obs/PKGBUILD ~/ah
cp ffmpeg-obs/031-ffmpeg-add-svt-vp9.patch ~/ah
cp ffmpeg-obs/add-av_stream_get_first_dts-for-chromium.patch ~/ah
cp ffmpeg-obs/license_if_nonfree_enabled.txt ~/ah
cp ffmpeg-obs/fix_build_with_texinfo-7.2.patch ~/ah
cd ~/ah
FFMPEG_OBS_FULL=on makepkg -sr --sign
rm -rf /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64/ffmpeg-obs*.pkg.tar.zst
rm -rf /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64/ffmpeg-obs*.pkg.tar.zst.sig
cp ffmpeg-obs*.pkg.tar.zst /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64/
cp ffmpeg-obs*.pkg.tar.zst.sig /mnt/Omar-Old-PC/mnt/nvme/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Repo/Aur
