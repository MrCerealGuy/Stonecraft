REM Make the Stonecraft Windows 64-bit client package
REM
REM Andreas "MrCerealGuy" Zahnleiter <mrcerealguy@gmx.de>

@echo off
setlocal

set _dest=..\..\Stonecraft-Release
set _vers=1.3.2
set _plat=Win64

mkdir %_dest%
mkdir %_dest%\bin
mkdir %_dest%\mods
mkdir %_dest%\games

set _what=/E

ROBOCOPY ..\bin                   %_dest%\bin                   *.exe
ROBOCOPY ..\bin                   %_dest%\bin                   *.dll
ROBOCOPY ..\builtin               %_dest%\builtin                                             %_what%
ROBOCOPY ..\client                %_dest%\client                                              %_what%
ROBOCOPY ..\clientmods            %_dest%\clientmods                                          %_what%
ROBOCOPY ..\fonts                 %_dest%\fonts                                               %_what%
ROBOCOPY ..\games\stonecraft_game %_dest%\games\stonecraft_game                               %_what%
ROBOCOPY ..\mods                  %_dest%\mods                  *.txt
ROBOCOPY ..\textures              %_dest%\textures                                            %_what%

ROBOCOPY ..\                      %_dest%                       README.md
ROBOCOPY ..\                      %_dest%                       LICENSE.txt
ROBOCOPY ..\                      %_dest%                       stonecraft.conf.example
ROBOCOPY ..\                      %_dest%                       stonecraft.conf.example.extra

7z a -tzip Stonecraft-%_vers%-%_plat%.zip -r %_dest%\*

pause
