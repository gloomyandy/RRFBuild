#!/bin/sh
echo $1 $2 $3 $4 $5 $6 $7 $8
BUILD=${1:-Debug}
CORE=${2:-STM32}
MCU=${3:-STM32F4}
VARIANT=$4
NETWORK=${5:-SBC}
FWNAME=${6:-firmware-${MCU,,}-${NETWORK,,}}
OUTNAME=${7:-${MCU,,}_iap_SBC}
STARTUP_DELAY=$8
#extract firmware version from header file
VER=`awk 'sub(/.*MAIN_VERSION/,""){print $1}' RepRapFirmware/src/Version.h  | awk 'gsub(/"/, "", $1)'`

OUTPUT=releases/${VER}/${BUILD}

mkdir -p ${OUTPUT}
mkdir -p ${OUTPUT}/base
mkdir -p ${OUTPUT}/map
mkdir -p ${OUTPUT}/mainboard
rm -f ${OUTPUT}/mainboard/${OUTNAME}.*
rm -f ${OUTPUT}/base/${OUTNAME}.*
rm -f ${OUTPUT}/map/${OUTNAME}.*
rm -f ${OUTPUT}/base/${FWNAME}-${VER,,}.zip

make distclean MAKE_DIR=IAP/makefiles/${MCU}
make -j8 CORE=${CORE} MCU=${MCU} VARIANT=${VARIANT} CONFIG=IAP_SPI_LOADER MAKE_DIR=IAP/makefiles/${MCU} all
if [ -f ./iapbuild/${OUTNAME}.bin ]; then
    cp ./iapbuild/${OUTNAME}.bin ${OUTPUT}/mainboard/${OUTNAME}.bin
    mv ./iapbuild/${OUTNAME}.bin ${OUTPUT}/base/${OUTNAME}.bin
    mv ./iapbuild/${OUTNAME}.map ${OUTPUT}/map/${OUTNAME}.map
fi 
