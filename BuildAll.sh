#!/bin/sh
./BuildRelease.sh Release STM32 SBC
./BuildRelease.sh Release STM32 ESP8266WIFI
./BuildRelease.sh Debug STM32 SBC
./BuildRelease.sh Debug STM32 ESP8266WIFI
./BuildRelease.sh Release LPC SBC
./BuildRelease.sh Release LPC ESP8266WIFI
./BuildRelease.sh Release LPC ETHERNET
#./BuildRelease.sh Release LPC NONE
./BuildRelease.sh Debug LPC SBC
./BuildRelease.sh Debug LPC ESP8266WIFI
./BuildRelease.sh Debug LPC ETHERNET
#./BuildRelease.sh Debug LPC NONE
