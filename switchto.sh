#!/bin/sh
echo "RRFBuild"
git status 
git checkout $1
cd CoreN2G
echo "CoreN2G"
git status
git checkout $1
cd ../RepRapFirmware
echo "RepRapFirmware"
git status
git checkout $1
cd ../RRFLibraries
echo "RRFLibraries"
git status
git checkout $1
cd ../CANlib
echo "CANlib"
git status
git checkout $1
cd ../IAP
echo "IAP"
git status
git checkout $1
cd ../FreeRTOS
echo "FreeRTOS"
git status
git checkout $1
cd ..
