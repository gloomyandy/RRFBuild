#!/bin/sh
echo $1 $2 $3 $4
BUILD=${1:-Debug}
CORE=${2:-STM32}
MCU=${3:-STM32F4}
NETWORK=${4:-SBC}
TMC22XX=${5:-true}
STARTUP_DELAY=$6
#extract firmware version from header file
VER=`awk 'sub(/.*MAIN_VERSION/,""){print $1}' RepRapFirmware/src/Version.h  | awk 'gsub(/"/, "", $1)'`

OUTPUT=releases/${VER}/${BUILD}

mkdir -p ${OUTPUT}
rm -f ${OUTPUT}/firmware-${MCU,,}-${NETWORK,,}-${VER,,}.*

make distclean
make -j8 firmware CORE=${CORE} MCU=${MCU} NETWORK=${NETWORK} BUILD=${BUILD} TMC22XX=${TMC22XX} OUTPUT_NAME=firmware-${MCU,,} STARTUP_DELAY=${STARTUP_DELAY}
if [ -f ./build/firmware-${MCU,,}.bin ]; then
        mv ./build/firmware-${MCU,,}.bin ${OUTPUT}/firmware-${MCU,,}-${NETWORK,,}-${VER,,}.bin
        mv ./build/firmware-${MCU,,}.map ${OUTPUT}/firmware-${MCU,,}-${NETWORK,,}-${VER,,}.map
fi 
