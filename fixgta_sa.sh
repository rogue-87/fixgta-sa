#!/usr/bin/env bash
# set -euo

### Download Latest Mods & Patches
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
    url=$(wget -qO- https://api.github.com/repos/"$repo"/releases/latest | jq '.assets[0].browser_download_url')

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
  echo "Downloading '$3'"
  wget -q --show-progress -O "$2" "$1"
  echo
}

installLatest(){
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
    ThirteenAG/III.VC.SA.WindowedMode
    aap/skygfx
  )
  downloadGithub "${github_repos[@]}"

  ## Download mods and patches from github repos with tags
  # Project2DFX by ThirteenAG
  url=$(wget -qO- https://api.github.com/repos/ThirteenAG/III.VC.SA.IV.Project2DFX/releases/1159120 | jq '.assets[0].browser_download_url')
  echo "Downloading Project2DFX"
  wget -q --show-progress $(echo "$url" | sed 's/"//g')
  echo

  # GTASA.WidescreenFix by ThirteenAG
  echo "Downloading WidescreenFix"
  wget -q --show-progress https://github.com/ThirteenAG/WidescreenFixesPack/releases/download/gtasa/GTASA.WidescreenFix.zip
  echo

  ## Download mods/patches from my repo
  mods_list=(
    "CLEOPlus.zip"
    "CrashInfo.zip"
    "FramerateVigilante.7z"
    "Improved_Streaming.7z"
    "Sky_Gradient_Fix.7z"
  )
  for  mod in "${mods_list[@]}";
  do
    echo
    wget -q --show-progress "https://github.com/rogue-87/fixgta-sa/raw/main/mods/latest/$mod"
    echo
  done
  #
  
  ## Install the mods & patches
  
  # bak up some files
  echo backing up some files ...
  sleep 2s
  mv gta_sa.exe gta_sa.exe.bak
  mv vorbisFile.dll vorbisFile.dll.bak 

  # Ultimate-ASI-Loader
  echo installing Ultimate-ASI-Loader
  sleep 2s
  7z x Ultimate-ASI-Loader.zip
  mv dinput8.dll vorbisFile.dll

  # Cleo & Cleo+
  echo 'installing Cleo & Cleo+'
  sleep 2s
  7z x CLEO4.zip -otemp/
  rm -rf temp/cleo_readme temp/cleo_sdk temp/vorbisFile.dll
  mv temp/* .

  7z x CLEOPlus.zip -otemp/
  mv temp/EN/CLEO/CLEO+.cleo ./cleo/
  rm -rf temp

  # modloader
  echo installing modloader
  sleep 2s
  7z x modloader.zip -otemp/
  mv temp/modloader . 
  mv temp/modloader.asi .
  rm -rf temp

  # Silent Patch
  echo installing SilentPatch
  sleep 2s
  7z x SilentPatchSA.zip -oSilentPatch
  rm SilentPatch/ReadMe.txt
  mv SilentPatch modloader

  rm ./*.zip ./*.7z ./*.rar
}
### End

installStable(){
  echo "Stil Work in progress..."
  sleep 1s
}

echo "Fix GTA-SA"
echo "Install ..."
opts=(
  "Latest mods/patches (Better compatibility with newer mods)"
  "Stable mods/patches (Worse compatibility with newer mods but better stability)" 
  "Exit"
)
PS3="Please select an option: "  # Set the prompt for user input
select opt in "${opts[@]}"; do
  # Code to execute based on the chosen option
  case $REPLY in
    1)
      echo "Installing latest mods and patches"
      installLatest
      ;;
    2)
      echo "Installing stable mods and patches"
      installStable
      ;;
    3)
      echo "Quitting..."
      sleep 2s
      echo "Goodbye :D"
      ;;
    *) 
      echo "Invalid option quitting"
      ;;
  esac
  break 
done
