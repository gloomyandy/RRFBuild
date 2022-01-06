#!/bin/sh
echo "RRFBuild"
git push
git push --tags
cd CoreN2G
echo "CoreN2G"
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
cd ../CANlib
echo "CANlib"
git push
git push --tags
cd ../IAP
echo "IAP"
git push
git push --tags
cd ../FreeRTOS
echo "FreeRTOS"
git push
git push --tags
cd ..
