#!/bin/sh
echo "RRFBuild"
git status
cd CoreN2G
echo "CoreN2G"
git status
cd ../RepRapFirmware
echo "RepRapFirmware"
git status
cd ../RRFLibraries
echo "RRFLibraries"
git status
cd ../CANlib
echo "CANlib"
git status
cd ../IAP
echo "IAP"
git status
cd ../FreeRTOS
echo "FreeRTOS"
git status
cd ../Duet3Expansion
echo "Duet3Expansion"
git status
cd ..
