#!/bin/sh
BUILD=${1:-Debug}
#extract firmware version from header file
VER=`awk 'sub(/.*MAIN_VERSION/,""){print $1}' RepRapFirmware/src/Version.h  | awk 'gsub(/"/, "", $1)'`

INPUT=releases/${VER}/${BUILD}
OUTPUT=/G/My\ Drive/3dp/stm32f4/${VER}
mkdir -p "${OUTPUT}"
cp ${INPUT}/*.bin "${OUTPUT}"
cp ${INPUT}/*.zip "${OUTPUT}"
cp ${INPUT}/*.uf2 "${OUTPUT}"
