#!/bin/sh
echo $1 $2 $3 $4
BUILD=${1:-Debug}
CORE=${2:-STM32}
MCU=${3:-STM32F4}
SDTYPE=${4:-2}
#extract firmware version from header file
VER=`awk 'sub(/.*MAIN_VERSION/,""){print $1}' RepRapFirmware/src/Version.h  | awk 'gsub(/"/, "", $1)'`

OUTPUT=releases/${VER}/${BUILD}

mkdir -p ${OUTPUT}
rm -f ${OUTPUT}/${MCU,,}_bootloader_${SDTYPE}.*

make distclean MAKE_DIR=IAP/makefiles/${MCU}
make -j8 CORE=${CORE} MCU=${MCU} CONFIG=IAP_BOOT_LOADER SDTYPE=${SDTYPE} MAKE_DIR=IAP/makefiles/${MCU} all
if [ -f ./iapbuild/${MCU,,}_bootloader_${SDTYPE}.bin ]; then
    mv ./iapbuild/${MCU,,}_bootloader_${SDTYPE}.bin ${OUTPUT}/${MCU,,}_bootloader_${SDTYPE}.bin
    mv ./iapbuild/${MCU,,}_bootloader_${SDTYPE}.map ${OUTPUT}/${MCU,,}_bootloader_${SDTYPE}.map
fi 
