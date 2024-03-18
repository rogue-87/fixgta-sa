#!/usr/bin/env bash
# set -euo

###
downloadRSV(){
  # 1st param is link
  # 2nd param is mod name (optional)
  echo "Downloading $2"
  wget -q --show-progress --no-check-certificate "$1"
  echo
}

downloadGithub(){
  # 1st param is list
  local github_repos=("$@")
  for repo in "${github_repos[@]}"; do
    # Capture download URL
    url=$(curl -s https://api.github.com/repos/"$repo"/releases/latest | jq '.assets[0].browser_download_url')

    # Check if url is not empty
    if [[ "$url" != null  && "$url" != "" ]]; then
      echo "Downloading $repo"
      wget -q --show-progress $(echo "$url" | sed 's/"//g')
      echo
    else
      echo "Error: Failed to download $repo"
      echo
    fi
  done
}

# This one needs more work as mods may come compressed in many formats
# but for now this works
downloadGtaGarage(){
  # 1st param is link
  # 2nd param is filename(must include the correct format)
  # 3rd param is mod name (optional)
  echo "Download '$3'"
  wget -q --show-progress -O "$2" "$1"
  echo
}
###

## Silent's patches/mods
downloadRSV https://silent.rockstarvision.com/uploads/SilentPatchSA.zip "SilentPatchSA"
downloadRSV https://silent.rockstarvision.com/uploads/GInputSA.zip "Ginput"

## GtaGrage
downloadGtaGarage https://www.gtagarage.com/mods/download.php?f=35121 "wshps.rar" "Widescreen HOR+ Support" 

## Download mods and patches from github
github_repos=(
  ThirteenAG/Ultimate-ASI-Loader
  thelink2012/modloader
  cleolibrary/CLEO4
  JuniorDjjr/CLEOPlus
  ThirteenAG/III.VC.SA.WindowedMode
  aap/skygfx
)
downloadGithub "${github_repos[@]}"

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

## Download from my github repo(mods from mixmods)
#
