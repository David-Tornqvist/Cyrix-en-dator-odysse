# define the name of the installer
Outfile "cyrix_installer.exe"
 
# define the directory to install to, the desktop in this case as specified  
# by the predefined $DESKTOP variable
InstallDir $PROGRAMFILES\cyrix
 
# default section
Section
 
# define the output path for this file
SetOutPath $INSTDIR
 
# define what to install and place it in the output path

File changes.txt
File cyrix.exe
File game.ico
File license.txt
File love.dll
File love.exe
File love.ico
File lovec.exe
File lua51.dll
File mpg123.dll
File msvcp120.dll
File msvcr120.dll
File OpenAL32.dll
File readme.txt
File SDL2.dll

CreateShortcut "$DESKTOP\cyrix.lnk" "$PROGRAMFILES\cyrix\cyrix.exe"
CreateShortcut "$SMPROGRAMS\cyrix.lnk" "$PROGRAMFILES\cyrix\cyrix.exe"

SectionEnd