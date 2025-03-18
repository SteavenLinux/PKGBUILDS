#!/bin/bash

# List of directories to process
directories=(
  "ddcci-driver-linux-dkms-git"
  "fastfetch"
  "gamescope-legeacy-bin"
  "hy3"
  "hyfetch"
  "SteavenGnome"
  "SteavenLinux-emulators-meta"
  "SteavenLinux-gaming-meta"
  "SteavenLinux-gnome-meta"
  "SteavenLinuxName"
  "SteavenLinux-plasma-meta"
  "SteavenLinux-printering-meta"
  "SteavenLinux-Nvidia-open-meta"
  "SteavenLinux-Nvidia-proprietary-meta"
  "SteavenLinux-Amd-meta"
  "SteavenLinux-Intel-meta"
  "SteavenSettings"
  "SteavenSettingsExtra"
  "zenergy-dkms-git"
  "SteavenLinux-plymouth-theme"
  "SteavenBuntu-Wallpapers"
)

# Loop through each directory and run the script
for dir in "${directories[@]}"; do
  if [ -d "$dir" ]; then
    echo "Entering directory: $dir"
    cd "$dir"
    if [ -f "add-to-steavenrepo.sh" ]; then
      echo "Running add-to-steavenrepo.sh in $dir"
      bash add-to-steavenrepo.sh
    else
      echo "add-to-steavenrepo.sh not found in $dir"
    fi
    cd ..
  else
    echo "Directory $dir does not exist"
  fi
done

echo "Script completed."

cd /home/omarhanykasban/GitHub/SteavenRepo
/home/omarhanykasban/GitHub/SteavenRepo/update.sh
git push