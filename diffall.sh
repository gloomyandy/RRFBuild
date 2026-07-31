#!/bin/sh
echo "RRFBuild"
git diff $1..$2
cd CoreN2G
echo "CoreN2G"
git diff $1..$2
cd ../RepRapFirmware
echo "RepRapFirmware"
git diff $1..$2
cd ../RRFLibraries
echo "RRFLibraries"
git diff $1..$2
cd ../CANlib
echo "CANlib"
git diff $1..$2
cd ../IAP
echo "IAP"
git diff $1..$2
cd ../FreeRTOS
echo "FreeRTOS"
git diff $1..$2
cd ../Duet3Expansion
echo "Duet3Expansion"
git diff $1..$2
cd ../DuetWebControl
echo "DuetWebControl"
git diff $1..$2
cd ..
