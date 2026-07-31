#!/bin/sh
git tag --delete $1
git push --delete origin $1
cd CoreN2G
git tag --delete $1
git push --delete origin $1
cd ../RepRapFirmware
git tag --delete $1
git push --delete origin $1
cd ../RRFLibraries
git tag --delete $1
git push --delete origin $1
cd ../CANlib
git tag --delete $1
git push --delete origin $1
cd ../FreeRTOS
git tag --delete $1
git push --delete origin $1
cd ../IAP
git tag --delete $1
git push --delete origin $1
cd ../Duet3Expansion
git tag --delete $1
git push --delete origin $1
#cd ../DuetWebControl
#git tag $1
cd ..
