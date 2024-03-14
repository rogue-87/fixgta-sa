#!/usr/bin/env bash
# set -euo

### Patches

# # Download SilentPatch
#
# wget --no-check-certificate https://silent.rockstarvision.com/uploads/SilentPatchSA.zip -O SilentPatch.zip



# Download mods and patches from github
github_repos=(ThirteenAG/Ultimate-ASI-Loader thelink2012/modloader ThirteenAG/III.VC.SA.WindowedMode cleolibraryCLEO4)

for ((i = 0; i < ${#repos[@]}; i++)); do
  # Capture download URL
  url=$(curl -s https://api.github.com/repos/${github_repos[$i]}/releases/latest | jq '.assets[0].browser_download_url')

  if [[ ! -z "$url" ]]; then
    echo "Downloading ${repos[i]}"
    # wget $(echo "$url" | sed 's/"//g')
  else
    echo "Error: Failed to download ${repo[i]}"
  fi
done
