### Fix GTA-SA

A script that sets up GTA San Andreas on Linux

All it does right now is downloading the mods/patches and installing them.

I wasn't able to fetch some of the mods so I had to include them in this repo

## Prerequisites

- wget
- jq
- 7z
- Downgraded version of San Andreas(v1.0)

#### **Please backup your game before running this script**

## Running the script

1. Open the terminal in the game directory and run this command(this will download the script).

```bash
wget https://raw.githubusercontent.com/rogue-87/fixgta-sa/main/fixgta-sa.sh
```

2. Run this command so the script can become executable

```bash
sudo chmod +x ./fixgta-sa.sh
```

3. Run the script

```bash
./fixgta-sa.sh
```

## Mods list

- [SilentPatch](https://cookieplmonster.github.io/mods/gta-sa/#silentpatch) by Silent
- [GInput](https://cookieplmonster.github.io/mods/gta-sa/#ginput) by Silent
- [Cleo+](https://www.mixmods.com.br/2023/10/cleoplus/) Junior_Djjr
- [CrashInfo](https://www.mixmods.com.br/2022/09/crashinfo/) Junior_Djjr
- [FramerateVigilante](https://www.mixmods.com.br/2022/08/iii-vc-sa-framerate-vigilante/) Junior_Djjr
- [Improved Streaming](https://www.mixmods.com.br/2022/04/improved-streaming/) by Junior_Djjr
- [WidescreenFix & Widescreen HOR+ Support ](https://www.mixmods.com.br/2021/05/widescreen-fix-para-gta-sa-corrigir-widescreen/) by ThirteenAG, and Wesser
- [WindowedMode](https://www.mixmods.com.br/2022/10/iii-vc-sa-windowed-mode/) by ThirteenAG
- [Project2DFX](https://github.com/ThirteenAG/III.VC.SA.IV.Project2DFX/releases/tag/gtasa) by ThirteenAG
- [Ultimate ASI Loader](https://github.com/ThirteenAG/Ultimate-ASI-Loader) by ThirteenAG
- [Cleolibrary/Cleo](https://github.com/cleolibrary/CLEO4)
- [Skygfx](https://github.com/aap/skygfx) by aap
- [SkyGrad](https://www.mixmods.com.br/2020/01/skygrad-sky-gradient-fix-corrigir-linhas-no-ceu/) by Wesser
- [Modloader](https://github.com/thelink2012/modloader) by thelink2012
- [Open Limit Adjuster](https://www.mixmods.com.br/2022/10/open-limit-adjuster/) by LINK/2012, ThirteenAG and Blackbird88
- [Debug Menu](https://github.com/aap/debugmenu) by aap
- [Gta Debug](https://github.com/aap/gtadebug) by aap
- [GTA-SA v1 Hoodlum](https://github.com/MrNiceGuy420/GTA-SA-1.0-HOODLUM-No-CD-Fix-exe) by MrNiceGuy420

**Thank yall for your keeping this game alive ❤️**

## Extra stuff

- #### [San Andreas modding guide by limemyth](https://steamcommunity.com/sharedfiles/filedetails/?id=2817786024)
- #### [Youtube guide by TJGM](https://youtube.com/playlist?list=PLhWmxGTRhiNOqUZq096SMy5vDX_lyw3VW&si=Nn632_yaKurRmhXl)

## TODOS

- [x] Script places mods in their correct location
- [ ] Script sets up wine prefixes
