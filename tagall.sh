#!/bin/sh
git tag $1
cd CoreLPC
git tag $1
cd ../CoreSTM32F4
git tag $1
cd ../RepRapFirmware
git tag $1
cd ../RRFLibraries
git tag $1
cd ../FreeRTOS
git tag $1
cd ..
