#!/bin/sh
#./BuildRelease.sh Release STM32F4 SBC
#./BuildRelease.sh Release STM32F4 WIFI
./BuildRelease.sh Debug STM32 STM32H7 STM32H743 WIFI firmware-stm32h7-wifi
./BuildRelease.sh Debug STM32 STM32H7 STM32H723 WIFI firmware-stm32h723-wifi
./BuildRelease.sh Debug STM32 STM32F4 "" SBC
./BuildRelease.sh Debug STM32 STM32F4 "" WIFI
./BuildIAPRelease.sh Debug STM32 STM32F4 SBC
./BuildIAPBLRelease.sh Debug STM32 STM32H7 2
./BuildExpRelease.sh Debug RP2040 FLY36RRF 0 "-DUSE_PICOCAN" "-picocan"
./BuildExpRelease.sh Debug RP2040 FLY36RRF 1 "-DUSE_SPICAN" "-spican"
#./BuildRelease.sh Release LPC SBC
#./BuildRelease.sh Release LPC WIFI
#./BuildRelease.sh Release LPC ETHERNET false
#./BuildRelease.sh Release LPC NONE
#./BuildRelease.sh Debug LPC SBC
#./BuildRelease.sh Debug LPC WIFI
#./BuildRelease.sh Debug LPC ETHERNET
#./BuildRelease.sh Debug LPC NONE
