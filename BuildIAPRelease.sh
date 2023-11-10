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
rm -f ${OUTPUT}/${OUTNAME}.*
rm -f ${OUTPUT}/${FWNAME}-${VER,,}.zip

make distclean MAKE_DIR=IAP/makefiles/${MCU}
make -j8 CORE=${CORE} MCU=${MCU} VARIANT=${VARIANT} CONFIG=IAP_SPI_LOADER MAKE_DIR=IAP/makefiles/${MCU} all
if [ -f ./iapbuild/${OUTNAME}.bin ]; then
    mv ./iapbuild/${OUTNAME}.bin ${OUTPUT}/${OUTNAME}.bin
    mv ./iapbuild/${OUTNAME}.map ${OUTPUT}/${OUTNAME}.map
    (cd ${OUTPUT}; /c/Windows/SysWOW64/tar.exe -a -c -f ${FWNAME}-${VER,,}.zip ${FWNAME}-${VER,,}.bin ${OUTNAME}.bin)
fi 
