#!/bin/sh
VER=`awk 'sub(/.*MAIN_VERSION/,""){print $1}' RepRapFirmware/src/Version.h  | awk 'gsub(/"/, "", $1)'`
OUTPUT=releases/${VER}/
rm -rf $OUTPUT
./BuildRelease.sh Debug STM32 STM32H7 STM32H743 COMBINED base-stm32h743
./BuildRelease.sh Debug STM32 STM32H7 STM32H723 COMBINED base-stm32h723
./BuildRelease.sh Debug STM32 STM32F4 "" COMBINED base-stm32f4
./BuildIAPRelease.sh Debug STM32 STM32H7 STM32H723 COMBINED base-stm32h723 stm32h723_iap_SBC
./BuildIAPRelease.sh Debug STM32 STM32H7 STM32H743 COMBINED base-stm32h743 stm32h743_iap_SBC
./BuildIAPRelease.sh Debug STM32 STM32F4 "" COMBINED base-stm32f4 stm32f4_iap_SBC
./BuildIAPBLRelease.sh Debug STM32 STM32H7 2
./BuildExpRelease.sh Debug RP2040 FLY36RRF 0 "-DUSE_PICOCAN" "FLY36RRF-picocan"
./BuildExpRelease.sh Debug RP2040 FLY36RRF 1 "-DUSE_SPICAN" "FLY36RRF"
./BuildExpRelease.sh Debug RP2040 FLYSB2040V1_0 0 "-DUSE_PICOCAN" "FLYSB2040V1_0-picocan"
./BuildExpRelease.sh Debug RP2040 SHT36 3 "-DUSE_SPICAN" "SHT36V3"
./BuildExpRelease.sh Debug RP2040 MKSTHR3642 1 "-DUSE_PICOCAN" "MKSTHR3642v1_0-picocan"
./BuildExpRelease.sh Debug RP2040 PITBV1_0 0 "-DUSE_PICOCAN" "PITBV1_0-picocan"
./BuildExpRelease.sh Debug RP2040 PITBV2_0 0 "-DUSE_SPICAN" "PITBV2_0"
./BuildExpRelease.sh Debug RP2040 STRIDEMAXV2_0 0 "-DUSE_SPICAN" "STRIDEMAXV2_0"
for board in boards/*_h743; do
    ./BuildBoardRelease.sh Debug STM32H7 COMBINED $(basename $board) base-stm32h743 firmware-$(basename $board) stm32h743_iap_SBC
done
for board in boards/*_h723; do
    ./BuildBoardRelease.sh Debug STM32H723 COMBINED $(basename $board) base-stm32h723 firmware-$(basename $board) stm32h723_iap_SBC
done
for board in boards/*_f4; do
    ./BuildBoardRelease.sh Debug STM32F4 COMBINED $(basename $board) base-stm32f4 firmware-$(basename $board) stm32f4_iap_SBC
done
