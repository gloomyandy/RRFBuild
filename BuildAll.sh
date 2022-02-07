#!/bin/sh
#./BuildRelease.sh Release STM32F4 SBC
#./BuildRelease.sh Release STM32F4 WIFI
./BuildRelease.sh Debug STM32 STM32H7 WIFI
./BuildRelease.sh Debug STM32 STM32F4 SBC
./BuildRelease.sh Debug STM32 STM32F4 WIFI
./BuildIAPRelease.sh Debug STM32 STM32F4 SBC
./BuildIAPBLRelease.sh Debug STM32 STM32H7 2
#./BuildRelease.sh Release LPC SBC
#./BuildRelease.sh Release LPC WIFI
#./BuildRelease.sh Release LPC ETHERNET false
#./BuildRelease.sh Release LPC NONE
#./BuildRelease.sh Debug LPC SBC
#./BuildRelease.sh Debug LPC WIFI
#./BuildRelease.sh Debug LPC ETHERNET
#./BuildRelease.sh Debug LPC NONE
