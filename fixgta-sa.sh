#!/usr/bin/env bash
# set -euo

### Download Latest Mods & Patches
downloadRSV(){
  # 1st param is link
  # 2nd param is mod name (optional)
  # echo "Downloading $2"
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
      # echo "Downloading $repo"
      wget -q --show-progress "$(echo "$url" | sed 's/"//g')"
      echo
    else
      echo "Error: Failed to download $repo"
      echo
    fi
  done
}

installLatest(){
  echo
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
  # echo "Downloading Project2DFX"
  wget -q --show-progress "$(echo "$url" | sed 's/"//g')"

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
  done
  #
  
  ## Install the mods & patches
  
  # bak up some files
  echo -e "\e[36mBacking up some files ...\e[0m"
  sleep 3s
  mv gta_sa.exe gta_sa.exe.bak
  mv vorbisFile.dll vorbisFile.dll.bak 
  echo

  # Ultimate-ASI-Loader
  echo -e "\e[33mInstalling Ultimate-ASI-Loader\e[0m"
  sleep 3s
  7z x Ultimate-ASI-Loader.zip
  mv -f dinput8.dll vorbisFile.dll
  echo

  # Cleo & Cleo+
  echo -e "\e[33mInstalling Cleo & Cleo+\e[0m"
  sleep 3s
  7z x CLEO4.zip -otemp/
  rm -rf temp/cleo_readme temp/cleo_sdk temp/vorbisFile.dll
  mv -f temp/* .
  echo

  7z x CLEOPlus.zip -otemp/
  mv -f temp/EN/CLEO/CLEO+.cleo ./cleo/
  rm -rf temp/*

  # modloader
  echo -e "\e[33mInstalling modloader\e[0m"
  sleep 3s
  7z x modloader.zip -otemp/
  mv -f temp/modloader . 
  mv -f temp/modloader.asi .
  rm -rf temp/*
  echo

  # Silent Patch
  echo -e "\e[33mInstalling SilentPatch\e[0m"
  sleep 3s
  7z x SilentPatchSA.zip -oSilentPatch/
  rm SilentPatch/ReadMe.txt
  mv -i SilentPatch modloader
  echo

  # Ginput
  echo -e "\e[33mInstalling Ginput\e[0m"
  sleep 3s
  7z x GInputSA.zip -oGInputSA
  mv -i GInputSA modloader
  echo

  # Debug menu
  echo -e "\e[33mInstalling Debug Menu\e[0m"
  sleep 3s
  7z x debugmenu_*.zip -otemp/ 
  mv -i temp/debugmenu/SA/debugmenu.dll .
  rm -rf temp/*
  echo

  # gtadebug
  echo -e "\e[33mInstalling gta-debug\e[0m"
  sleep 3s
  7z x gtadebug.zip
  rm gtadebug/iii_debug.dll
  rm gtadebug/vc_debug.dll
  mv gtadebug/sa_debug.dll gtadebug/sa_debug.asi
  mv -i gtadebug modloader
  echo

  # Widescreen fix
  echo -e "\e[33mInstalling WidescreenFix\e[0m"
  sleep 3s
  7z x SA_Widescreen_Fix2018.7z -otemp/
  mv -i temp/"Widescreen Fix by ThirteenAG" modloader
  mv -i temp/"Widescreen HOR+ Support by Wesser" modloader
  rm -rf temp/*
  echo

  # Project2DFX
  echo -e "\e[33mInstalling Project2DFX\e[0m"
  sleep 3s
  7z x SA_Project2DFX.7z -otemp/
  mv -i temp/Project2DFX modloader
  rm -rf temp/*
  echo

  # Windowed Mode
  echo -e "\e[33mInstalling Windowed Mode\e[0m"
  sleep 3s
  7z x SA_VC_III_Windowed_Mode.zip -otemp/
  mv -i "temp/Windowed Mode" modloader
  rm -rf temp/*
  echo

  # SkyGfx
  echo -e "\e[33mInstalling SkyGfx\e[0m"
  sleep 3s
  7z x SkyGfx.7z -otemp/
  mv -i temp/SkyGfx modloader
  mv -i "temp/(fix)/CLEO/Fix Wood Blood Drops.cs" cleo
  rm -rf temp/*
  echo

  # Sky Gradient Fix
  echo -e "\e[33mInstalling Sky Gradient Fix\e[0m"
  sleep 3s
  7z x Sky_Gradient_Fix.7z -otemp/
  mv -i temp/SkyGrad modloader
  rm -rf temp/*
  echo

  # Crash Info
  echo -e "\e[33mInstalling Crash Info\e[0m"
  sleep 3s
  7z x CrashInfo.zip -otemp/
  cp -r "temp/(SA)/EN/(mod - to the game folder)/." ./
  rm -rf temp/*
  echo

  # FramerateVigilante
  echo -e "\e[33mInstalling FramerateVigilante\e[0m"
  sleep 3s
  7z x FramerateVigilante.7z -otemp/
  mv -i "temp/GTA SA/FramerateVigilante" modloader
  rm -rf temp/*
  echo

  # Improved Streaming
  echo -e "\e[33mInstalling Improved_Streaming\e[0m"
  sleep 3s
  7z x Improved_Streaming.7z -otemp/
  mv -i "temp/EN/Improved Streaming" modloader
  rm -rf temp/*
  echo

  # Hoodlum
  echo "Installing Hoodlum"
  wget -q --show-progress "https://github.com/rogue-87/fixgta-sa/raw/main/mods/latest/gta_sa.exe"
  sleep 2s

  rm ./*.zip ./*.7z
  echo -e "\e[32mDone!\e[0m"
  echo "Don't forget to delete the temp folder(it's unnecessary)"
  sleep 1s
}
### End

installMinimal(){
  echo "Sorry, still work in progress..."
  sleep 1s
}

echo -e "\e[33mFix GTA-SA\e[0m"
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
