@echo off
SETLOCAL

set newLocale="enUS"

REM -- check if script is executed from the non-wow directory
if not exist wow.exe (
  echo Could not find the World of Warcraft executable! Please check if the files have been put in the correct folder.
  pause
  exit 0
)

REM -- check for the WTF folder
if not exist WTF (
  echo Could not find the WTF folder! Please start the game for it to be created.
  pause
  exit 0
)

cd WTF

REM -- check for config.wtf
if not exist config.wtf (
  echo Config.wtf not found! Please start the game for it to be created.
  pause
  exit 0
)

REM -- remove read-only if set
attrib -r config.wtf /s /d

REM -- create a new file without the locale entry
findstr /v /i "locale" "config.wtf" > "config_temp.wtf"

REM -- Set our new locale at the end of the file
echo SET locale %newLocale% >> config_temp.wtf

REM -- backup our old config
IF EXIST Config.wtf.bak DEL /F Config.wtf.bak
ren Config.wtf Config.wtf.bak

REM -- Apply our new config
ren config_temp.wtf Config.wtf

echo Locale changed to %newLocale%

cd ..
ENDLOCAL
pause