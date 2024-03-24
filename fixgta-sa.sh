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

installLatest(){
  ## Silent's patches/mods
  downloadRSV https://silent.rockstarvision.com/uploads/SilentPatchSA.zip "SilentPatchSA"
  downloadRSV https://silent.rockstarvision.com/uploads/GInputSA.zip "Ginput"

  ## Download mods and patches from github
  github_repos=(
    "ThirteenAG/Ultimate-ASI-Loader"
    "cleolibrary/CLEO4"
    "thelink2012/modloader"
    "aap/debugmenu"
    "aap/gtadebug"
  )
  downloadGithub "${github_repos[@]}"

  ## Download mods and patches from github repos with tags
  # Project2DFX by ThirteenAG
  url=$(wget -qO- https://api.github.com/repos/ThirteenAG/III.VC.SA.IV.Project2DFX/releases/1159120 | jq '.assets[0].browser_download_url')
  echo "Downloading Project2DFX"
  wget -q --show-progress $(echo "$url" | sed 's/"//g')
  echo

  ## Download mods/patches from my repo
  mods_list=(
    "CLEOPlus.zip"
    "CrashInfo.zip"
    "FramerateVigilante.7z"
    "Improved_Streaming.7z"
    "SA_Project2DFX.7z"
    "SA_VC_III_Windowed_Mode.zip"
    "SA_Widescreen_Fix2018.7z"
    "SkyGfx.7z"
    "Sky_Gradient_Fix.7z"
  )
  for mod in "${mods_list[@]}";
  do
    echo
    wget -q --show-progress "https://github.com/rogue-87/fixgta-sa/raw/main/mods/latest/$mod"
    echo
  done
  #
  
  ## Install the mods & patches
  
  # bak up some files
  echo "Backing up some files ..."
  sleep 2s
  mv gta_sa.exe gta_sa.exe.bak
  mv vorbisFile.dll vorbisFile.dll.bak 
  echo

  # Ultimate-ASI-Loader
  echo "Installing Ultimate-ASI-Loader"
  sleep 2s
  7z x Ultimate-ASI-Loader.zip
  mv dinput8.dll vorbisFile.dll
  echo

  # Cleo & Cleo+
  echo "Installing Cleo & Cleo+"
  sleep 2s
  7z x CLEO4.zip -otemp/
  rm -rf temp/cleo_readme temp/cleo_sdk temp/vorbisFile.dll
  mv temp/* .
  echo

  7z x CLEOPlus.zip -otemp/
  mv temp/EN/CLEO/CLEO+.cleo ./cleo/
  rm -rf temp/*

  # modloader
  echo "Installing modloader"
  sleep 2s
  7z x modloader.zip -otemp/
  mv temp/modloader . 
  mv temp/modloader.asi .
  rm -rf temp/*
  echo

  # Silent Patch
  echo "Installing SilentPatch"
  sleep 2s
  7z x SilentPatchSA.zip -oSilentPatch/
  rm SilentPatch/ReadMe.txt
  mv SilentPatch modloader
  echo

  # Ginput
  echo "Installing Ginput"
  sleep 2s
  7z x GInputSA.zip -oGInputSA
  mv GInputSA modloader
  echo

  # Debug menu
  echo "Installing Debug Menu"
  sleep 2s
  7z x debugmenu_*.zip -otemp/ 
  mv temp/debugmenu/SA/debugmenu.dll .
  rm -rf temp/*
  echo

  # gtadebug
  echo "Installing gta-debug"
  sleep 2s
  7z x gtadebug.zip
  rm gtadebug/iii_debug.dll
  rm gtadebug/vc_debug.dll
  mv gtadebug/sa_debug.dll gtadebug/sa_debug.asi
  mv gtadebug modloader
  echo

  # Widescreen fix
  echo "Installing WidescreenFix"
  sleep 2s
  7z x SA_Widescreen_Fix2018.7z -otemp/
  mv temp/"Widescreen Fix by ThirteenAG" modloader
  mv temp/"Widescreen HOR+ Support by Wesser" modloader
  rm -rf temp/*
  echo

  # Project2DFX
  echo "Installing Project2DFX"
  sleep 2s
  7z x SA_Project2DFX.7z -otemp/
  mv temp/Project2DFX modloader
  rm -rf temp/*
  echo

  # Windowed Mode
  echo "Installing Windowed Mode"
  sleep 2s
  7z x SA_VC_III_Windowed_Mode.zip -otemp/
  mv "temp/Windowed Mode" modloader
  rm -rf temp/*
  echo

  # SkyGfx
  echo "Installing SkyGfx"
  sleep 2s
  7z x SkyGfx.7z -otemp/
  mv temp/SkyGfx modloader
  mv "temp/(fix)/CLEO/Fix Wood Blood Drops.cs" cleo
  rm -rf temp/*
  echo

  # Sky Gradient Fix
  echo "Installing Sky Gradient Fix"
  sleep 2s
  7z x Sky_Gradient_Fix.7z -otemp/
  mv temp/SkyGrad modloader
  rm -rf temp/*
  echo

  # Crash Info
  echo "Installing Crash Info"
  sleep 2s
  7z x CrashInfo.zip -otemp/
  cp -r "temp/(SA)/EN/(mod - to the game folder)/." ./
  rm -rf temp/*
  echo

  # FramerateVigilante
  echo "Installing FramerateVigilante"
  sleep 2s
  7z x FramerateVigilante.7z -otemp/
  mv "temp/GTA SA/FramerateVigilante" modloader
  rm -rf temp/*
  echo

  # Improved Streaming
  echo "Installing Improved_Streaming"
  sleep 2s
  7z x Improved_Streaming.7z -otemp/
  mv "temp/EN/Improved Streaming" modloader
  rm -rf temp/*
  echo

  # Hoodlum
  # echo "Installing Hoodlum"
  # sleep 2s

  rm ./*.zip ./*.7z
  echo "Done!"
  sleep 1s
  echo "Don't forget to delete the temp folder(it's not unnecessary)"
}
### End

installMinimal(){
  echo "Sorry, stil Work in progress..."
  sleep 1s
}

echo "Fix GTA-SA"
echo "Install ..."
opts=(
  "Recommended mods/patches"
  "Minimal(asi-loader, cleo, modloader and silent patch)" 
  "Exit script"
)
PS3="Please select an option: "  # Set the prompt for user input
select opt in "${opts[@]}"; do
  # Code to execute based on the chosen option
  case $REPLY in
    1)
      echo "Installing mods and patches"
      installLatest
      ;;
    2)
      installMinimal
      ;;
    3)
      echo "Quitting..."
      sleep 2s
      echo "Goodbye :D"
      ;;
    *) 
      echo "Invalid option, quitting"
      ;;
  esac
  break 
done
