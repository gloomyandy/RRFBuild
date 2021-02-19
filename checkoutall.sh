#!/bin/sh
echo "RRFBuild"
git checkout $1
cd CoreLPC
echo "CoreLPC"
git checkout $1
cd ../CoreSTM32F4
echo "CoreSTM32F4"
git checkout $1
cd ../RepRapFirmware
echo "RepRapFirmware"
git checkout $1
cd ../RRFLibraries
echo "RRFLibraries"
git checkout $1
cd ../FreeRTOS
echo "FreeRTOS"
git checkout $1
cd ..
