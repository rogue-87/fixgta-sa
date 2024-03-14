#!/usr/bin/env bash
# set -euo

### Patches
# # First, download SilentPatch
# wget --no-check-certificate https://silent.rockstarvision.com/uploads/SilentPatchSA.zip -O SilentPatch.zip

# Download mods and patches from github
owners=(ThirteenAG thelink2012 ThirteenAG)
repos=(Ultimate-ASI-Loader modloader III.VC.SA.WindowedMode)
# filenames=("Ultimate-ASI-Loader.zip" "modloader.zip" "III.VC.SA.WindowedMode.zip")

if [[ ${#owners[@]} == ${#repos[@]} ]]; then
  for ((i = 0; i < ${#repos[@]}; i++)); do
    # Capture download URL
    url=$(curl -s https://api.github.com/repos/${owners[$i]}/${repos[$i]}/releases/latest | jq '.assets[0].browser_download_url')

    if [[ ! -z "$url" ]]; then
      echo "Downloading ${repos[i]}"
      wget $(echo "$url" | sed 's/"//g')
    else
      echo "Error: Failed to download ${repo[i]}"
    fi
  done
fi

### Mods
