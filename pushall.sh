#!/bin/sh
echo "RRFBuild"
git push
git push --tags
cd CoreLPC
echo "CoreLPC"
git push
git push --tags
cd ../CoreSTM32F4
echo "CoreSTM32F4"
git push
git push --tags
cd ../RepRapFirmware
echo "RepRapFirmware"
git push
git push --tags
cd ../RRFLibraries
echo "RRFLibraries"
git push
git push --tags
cd ../FreeRTOS
echo "FreeRTOS"
git push
git push --tags
cd ..
