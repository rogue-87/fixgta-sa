#!/bin/bash
# set -euo

### Download Latest Mods & Patches
function download-rsv(){
  # 1st param is link
  wget --no-check-certificate "$1"
}

function download-github(){
  # 1st param is list
  local github_repos=("$@")
  for repo in "${github_repos[@]}"; do
    # Capture download URL
    url=$(wget -qO- https://api.github.com/repos/"$repo"/releases/latest | jq '.assets[0].browser_download_url')

    # Check if url is not empty
    if [[ "$url" != null  && "$url" != "" ]]; then
      wget  "$(echo "$url" | sed 's/"//g')"
    else
      echo "Error: Failed to download $repo"
    fi
  done
}

# extract modloader mods
# not ready yet
function extract-mod(){
  7z x "modname" -otemp/$count/
  # INSERT CODE TO MOVE FILES HERE
  (( count++ ))
}

# extract cleo mod
# not ready yet
function extract-cleo-mod(){
  echo "not done yet lol"
}

function install-latest(){
  echo
  ## Silent's patches/mods
  download-rsv https://silent.rockstarvision.com/uploads/SilentPatchSA.zip "SilentPatchSA"
  download-rsv https://silent.rockstarvision.com/uploads/GInputSA.zip "Ginput"

  ## Download mods and patches from github
  github_repos=(
    "ThirteenAG/Ultimate-ASI-Loader"
    "cleolibrary/CLEO4"
    "thelink2012/modloader"
    "aap/debugmenu"
    "aap/gtadebug"
  )
  download-github "${github_repos[@]}"

  ## Download mods and patches from github repos with tags
  # Project2DFX by ThirteenAG
  url=$(wget -qO- https://api.github.com/repos/ThirteenAG/III.VC.SA.IV.Project2DFX/releases/1159120 | jq '.assets[0].browser_download_url')
  wget "$(echo "$url" | sed 's/"//g')"

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
    wget "https://github.com/rogue-87/fixgta-sa/raw/main/mods/latest/$mod"
  done
  
  ## Install the mods & patches
  # bak up some files
  echo -e "\e[36mBacking up some files ...\e[0m"
  sleep 3s
  mv gta_sa.exe gta_sa.exe.bak
  mv vorbisFile.dll vorbisFile.dll.bak 
  echo

  # make trash folder("rm -r" ain't safe lol)
  mkdir trash
  local timer="1s"
  local count=1

  # Ultimate-ASI-Loader
  echo -e "\e[33mExtracting Ultimate-ASI-Loader\e[0m"
  sleep $timer
  7z x Ultimate-ASI-Loader.zip
  mv -f dinput8.dll vorbisFile.dll
  echo

  # Cleo & Cleo+
  echo -e "\e[33mExtracting Cleo\e[0m"
  sleep $timer
  7z x CLEO4.zip -otemp/$count/
  mv -f temp/$count/cleo_readme temp/$count/cleo_sdk temp/$count/vorbisFile.dll trash/
  mv -f temp/$count/* .
  (( count++ ))
  
  echo -e "\e[33mExtracting Cleo+\e[0m"
  7z x CLEOPlus.zip -otemp/$count/
  mv -f temp/$count/EN/CLEO/CLEO+.cleo ./cleo/
  mv -f temp/* trash
  (( count++ ))

  # modloader
  echo -e "\e[33mExtracting modloader\e[0m"
  sleep $timer
  7z x modloader.zip -otemp/$count/
  mv -f temp/$count/modloader temp/$count/modloader.asi . 
  mv -f temp/* trash
  (( count++ ))
  echo

  # Silent Patch
  echo -e "\e[33mExtracting SilentPatch\e[0m"
  sleep $timer
  7z x SilentPatchSA.zip -oSilentPatch/
  # rm SilentPatch/ReadMe.txt
  mv -i SilentPatch modloader
  echo

  # Ginput
  echo -e "\e[33mExtracting Ginput\e[0m"
  sleep $timer
  7z x GInputSA.zip -oGInputSA
  mv -i GInputSA modloader
  echo

  # Debug menu
  echo -e "\e[33mExtracting Debug Menu\e[0m"
  sleep $timer
  7z x debugmenu_*.zip -otemp/$count/ 
  mv -i temp/$count/debugmenu/SA/debugmenu.dll .
  mv -f temp/* trash
  (( count++ ))
  echo

  # gtadebug
  echo -e "\e[33mExtracting gta-debug\e[0m"
  sleep $timer
  7z x gtadebug.zip
  rm gtadebug/iii_debug.dll gtadebug/vc_debug.dll
  mv gtadebug/sa_debug.dll gtadebug/sa_debug.asi
  mv -i gtadebug modloader
  echo

  # Widescreen fix
  echo -e "\e[33mExtracting WidescreenFix\e[0m"
  sleep $timer
  7z x SA_Widescreen_Fix2018.7z -otemp/$count/
  mv -i temp/$count/"Widescreen Fix by ThirteenAG" modloader
  mv -i temp/$count/"Widescreen HOR+ Support by Wesser" modloader
  mv -f temp/* trash
  (( count++ ))
  echo

  # Project2DFX
  echo -e "\e[33mExtracting Project2DFX\e[0m"
  sleep $timer
  7z x SA_Project2DFX.7z -otemp/$count/
  mv -i temp/$count/Project2DFX modloader
  mv -f temp/* trash
  (( count++ ))
  echo

  # Windowed Mode
  echo -e "\e[33mExtracting Windowed Mode\e[0m"
  sleep $timer
  7z x SA_VC_III_Windowed_Mode.zip -otemp/$count/
  mv -i "temp/$count/Windowed Mode" modloader
  mv -f temp/* trash
  (( count++ ))
  echo

  # SkyGfx
  echo -e "\e[33mExtracting SkyGfx\e[0m"
  sleep $timer
  7z x SkyGfx.7z -otemp/$count/
  mv -i temp/$count/SkyGfx modloader
  mv -i "temp/$count/(fix)/CLEO/Fix Wood Blood Drops.cs" cleo
  mv -f temp/* trash
  (( count++ ))
  echo

  # Sky Gradient Fix
  echo -e "\e[33mExtracting Sky Gradient Fix\e[0m"
  sleep $timer
  7z x Sky_Gradient_Fix.7z -otemp/$count/
  mv -i temp/$count/SkyGrad modloader
  mv -f temp/* trash
  (( count++ ))
  echo

  # Crash Info
  echo -e "\e[33mExtracting Crash Info\e[0m"
  sleep $timer
  7z x CrashInfo.zip -otemp/$count/
  cp -r "temp/$count/(SA)/EN/(mod - to the game folder)/." ./
  mv -f temp/* trash
  (( count++ ))
  echo

  # FramerateVigilante
  echo -e "\e[33mExtracting FramerateVigilante\e[0m"
  sleep $timer
  7z x FramerateVigilante.7z -otemp/$count/
  mv -i "temp/$count/GTA SA/FramerateVigilante" modloader
  mv -f temp/* trash
  (( count++ ))
  echo

  # Improved Streaming
  echo -e "\e[33mExtracting Improved_Streaming\e[0m"
  sleep $timer
  7z x Improved_Streaming.7z -otemp/$count/
  mv -i "temp/$count/EN/Improved Streaming" modloader
  mv -f temp/* trash
  (( count++ ))
  echo

  # Hoodlum
  echo "Downloading Hoodlum crack"
  wget "https://github.com/rogue-87/fixgta-sa/raw/main/mods/latest/gta_sa.exe"
  sleep $timer

  rm ./*.zip ./*.7z
  echo -e "\e[32mDone!\e[0m"
  echo "Don't forget to delete the temp and trash folders(they're useless)"
  sleep $timer
}

function install-minimal(){
  echo "Sorry, still work in progress..."
  sleep $timer
}

echo -e "\e[33mFix GTA-SA\e[0m"
echo "Install ..."
opts=(
  "Recommended mods/patches"
  "Minimal(asi-loader, cleo, modloader and silent patch)" 
  "Exit script"
)
PS3="Please select an option: "
select opt in "${opts[@]}"; do
  case $REPLY in
    1)
      echo "Installing mods and patches"
      install-latest
      ;;
    2)
      install-minimal
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
