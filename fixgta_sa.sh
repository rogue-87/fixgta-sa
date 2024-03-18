#!/usr/bin/env bash
# set -euo

## Silent's patches/mods

echo "Downloading SilentPatch"
wget -q --show-progress --no-check-certificate https://silent.rockstarvision.com/uploads/SilentPatchSA.zip -O SilentPatch.zip
echo

echo "Downloading Ginput"
wget -q --show-progress --no-check-certificate https://silent.rockstarvision.com/uploads/GInputSA.zip
echo

## Wesser's Widescreen HOR+ Support mod
echo "Downloading Widescreen HOR+ Support"
wget -q --show-progress -O wshps.rar 'https://www.gtagarage.com/mods/download.php?f=35121'
echo

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
  url=$(curl -s https://api.github.com/repos/"${github_repos[$i]}"/releases/latest | jq '.assets[0].browser_download_url')

  # Check if url is not empty
  if [[ ! -z "$url" ]]; then
    echo "Downloading ${github_repos[i]}"
    wget -q --show-progress $(echo "$url" | sed 's/"//g')
    echo
  else
    echo "Error: Failed to download ${github_repos[i]}"
    echo
  fi
done

## Download mods and patches from github repos with tags

# Project2DFX by ThirteenAG
url=$(curl -s https://api.github.com/repos/ThirteenAG/III.VC.SA.IV.Project2DFX/releases/1159120 | jq '.assets[0].browser_download_url')
echo "Downloading Project2DFX"
wget -q --show-progress $(echo "$url" | sed 's/"//g')
echo

# GTASA.WidescreenFix by ThirteenAG
echo "Downloading WidescreenFix"
wget -q --show-progress https://github.com/ThirteenAG/WidescreenFixesPack/releases/download/gtasa/GTASA.WidescreenFix.zip
echo
