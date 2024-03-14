#!/usr/bin/env bash
set -euo

# # First, download SilentPatch
# wget --no-check-certificate https://silent.rockstarvision.com/uploads/SilentPatchSA.zip -O SilentPatch.zip

# Just for reference
# release_url=$(curl -s https://api.github.com/repos/$owner/$repo/releases/latest)
# Download mods and patches from github
owners=(ThirteenAG thelink2012 ThirteenAG)
repos=(Ultimate-ASI-Loader modloader III.VC.SA.WindowedMode)
filenames=("Ultimate-ASI-Loader.zip" "modloader.zip" "III.VC.SA.WindowedMode.zip")

if [[ condition ]]; then
  
fi
# for ((i = 0; i < ${#repos[@]}; i++)); do
#   echo https://api.github.com/repos/${owners[$i]}/${repos[$i]}/releases/latest
# done
