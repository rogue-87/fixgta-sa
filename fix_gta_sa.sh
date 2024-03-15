#!/usr/bin/env bash
# set -euo

### Patches

# ## Silent's patches/mods
#
# echo "Downloading SilentPatch"
# wget --no-check-certificate https://silent.rockstarvision.com/uploads/SilentPatchSA.zip -O SilentPatch.zip
# 
# echo "Downloading Ginput"
# wget --no-check-certificate https://silent.rockstarvision.com/uploads/GInputSA.zip
#

# wget -O wshps.rar 'https://www.gtagarage.com/mods/download.php?f=35121'

## Download mods and patches from github
github_repos=(
  ThirteenAG/Ultimate-ASI-Loader
  thelink2012/modloader
  cleolibrary/CLEO4
  JuniorDjjr/CLEOPlus
  ThirteenAG/III.VC.SA.WindowedMode
  aap/skygfx
)
# ThirteenAG/III.VC.SA.IV.Project2DFX/releases/1159120
# ThirteenAG/WidescreenFixesPack # for some reason it doesn't list all the releases ID for this one'

for ((i = 0; i < ${#github_repos[@]}; i++)); do
  # Capture download URL
  url=$(curl -s https://api.github.com/repos/${github_repos[$i]}/releases/latest | jq '.assets[0].browser_download_url')
  echo "$url"

  # Check if url is not empty
  if [[ ! -z "$url" ]]; then
    echo
    echo "Downloading ${github_repos[i]}"
    wget $(echo "$url" | sed 's/"//g')
  else
    echo
    echo "Error: Failed to download ${github_repo[i]}"
  fi
done

## Download mods and patches from github repos with tags

# Project2DFX by ThirteenAG
url=$(curl -s https://api.github.com/repos/ThirteenAG/III.VC.SA.IV.Project2DFX/releases/1159120 | jq '.assets[0].browser_download_url')
echo "Downloading Project2DFX"
echo
wget $(echo $url | sed 's/"//g')

# GTASA.WidescreenFix by ThirteenAG
wget https://github.com/ThirteenAG/WidescreenFixesPack/releases/download/gtasa/GTASA.WidescreenFix.zip
