#!/bin/sh
#./BuildRelease.sh Release STM32F4 SBC
#./BuildRelease.sh Release STM32F4 WIFI
./BuildRelease.sh Debug STM32 STM32H7 STM32H743 WIFI firmware-stm32h7-wifi
./BuildRelease.sh Debug STM32 STM32H7 STM32H723 WIFI firmware-stm32h723-wifi
./BuildRelease.sh Debug STM32 STM32H7 STM32H723 SBC firmware-stm32h723-sbc
./BuildRelease.sh Debug STM32 STM32H7 STM32H743 SBC firmware-stm32h7-sbc
./BuildRelease.sh Debug STM32 STM32F4 "" SBC
./BuildRelease.sh Debug STM32 STM32F4 "" WIFI
./BuildIAPRelease.sh Debug STM32 STM32H7 STM32H723 SBC firmware-stm32h723-sbc stm32h723_iap_SBC
./BuildIAPRelease.sh Debug STM32 STM32H7 STM32H743 SBC firmware-stm32h7-sbc stm32h7_iap_SBC
./BuildIAPRelease.sh Debug STM32 STM32F4 "" SBC firmware-stm32f4-sbc stm32f4_iap_SBC
./BuildIAPBLRelease.sh Debug STM32 STM32H7 2
./BuildExpRelease.sh Debug RP2040 FLY36RRF 0 "-DUSE_PICOCAN" "-picocan"
./BuildExpRelease.sh Debug RP2040 FLY36RRF 1 "-DUSE_SPICAN"
./BuildExpRelease.sh Debug RP2040 FLYSB2040V1_0 0 "-DUSE_PICOCAN" "-picocan"
./BuildExpRelease.sh Debug RP2040 PITBV1_0 0 "-DUSE_PICOCAN" "-picocan"
./BuildExpRelease.sh Debug RP2040 STRIDEMAXV1_0 0 "-DUSE_SPICAN"