#!/bin/sh
echo $1 $2 $3
BUILD=${1:-Debug}
CORE=${2:-STM32}
NETWORK=${3:-SBC}
#extract firmware version from header file
VER=`awk 'sub(/.*MAIN_VERSION/,""){print $1}' RepRapFirmware/src/Version.h  | awk 'gsub(/"/, "", $1)'`

OUTPUT=releases/${VER}/${CORE}/${BUILD}

mkdir -p ${OUTPUT}

make distclean
make -j2 firmware CORE=${CORE} NETWORK=${NETWORK} BUILD=${BUILD} OUTPUT_NAME=firmware
if [ -f ./build/firmware.bin ]; then
        mv ./build/firmware.bin ${OUTPUT}/firmware-${NETWORK,,}.bin
        mv ./build/firmware.map ${OUTPUT}/firmware-${NETWORK,,}.map
fi 
