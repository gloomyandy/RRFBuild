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
cd ../Duet3Expansion
echo "Duet3Expansion"
git push
git push --tags
cd ../DuetWebServer
echo "DuetWebServer"
git push
git push --tags
cd ../WiFiSocketServerRTOS
echo "WiFiSocketServerRTOS"
git push
git push --tags
cd ../esp-idf
echo "esp-idf"
git push
git push --tags
cd ..
