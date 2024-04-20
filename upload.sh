#!/bin/sh
BUILD=${1:-Debug}
#extract firmware version from header file
VER=`awk 'sub(/.*MAIN_VERSION/,""){print $1}' RepRapFirmware/src/Version.h  | awk 'gsub(/"/, "", $1)'`

INPUT=releases/${VER}
OUTPUT=/G/My\ Drive/3dp/stm32f4/${VER}
mkdir -p "${OUTPUT}"
mkdir -p "${OUTPUT}/mainboard"
mkdir -p "${OUTPUT}/expansion"
mkdir -p "${OUTPUT}/base"
mkdir -p "${OUTPUT}/wifi"
cp ${INPUT}/expansion/* "${OUTPUT}/expansion"
cp -r ${INPUT}/mainboard/* "${OUTPUT}/mainboard"
cp ${INPUT}/base/* "${OUTPUT}/base"
cp -r ${INPUT}/wifi/* "${OUTPUT}/wifi"
cp ${INPUT}/*.zip "${OUTPUT}/"
