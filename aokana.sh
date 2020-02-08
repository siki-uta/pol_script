#!/usr/bin/env playonlinux-bash       
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
TITLE="AoNoKanataNoFourRhythmPerfectEdition"
PREFIX="aokanaPE"
EDITOR="Sprite"
GAME_URL="https://aokana.net/products/anniversarybox/"
WINEVERSION="4.21"
AUTHOR="sikiuta"
POL_SetupWindow_Init
# Initialize the script and debugging
POL_SetupWindow_Init
POL_Debug_Init
  
# Setup presentation window
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Begin setting up the Wine Prefix
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
 
# Installs components needed to install game and play movies

POL_Call POL_Install_quartz

POL_Wine_OverrideDLL "" "winegstreamer" # To disable the DLL
# Ask user for either DVD or Local installation
POL_SetupWindow_InstallMethod "LOCAL,DVD"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then
        # Ask user to find "Setup.exe"
    cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please locate installation program (Setup.exe)')" "$TITLE"
        POL_Wine_WaitBefore "$TITLE"
        POL_Wine "$APP_ANSWER" /silent
 
elif [ "$INSTALL_METHOD" = "DVD" ]
then
        # Launches the installation program from CD/DVD
        POL_SetupWindow_cdrom
        POL_Wine_WaitBefore "$TITLE"
        POL_Wine "$CDROM/Setup.exe" /silent
fi
  
# Create a shortcut for easy access
POL_Shortcut "蒼の彼方のフォーリズムPerfect Edition.exe" "$TITLE"

POL_SetupWindow_Close
exit 0
