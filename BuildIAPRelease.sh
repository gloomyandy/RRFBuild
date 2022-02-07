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
rm -f ${OUTPUT}/${MCU,,}_iap_SBC.*
rm -f ${OUTPUT}/firmware-${MCU,,}-${NETWORK,,}-${VER,,}.zip

make distclean MAKE_DIR=IAP/makefiles/${MCU}
make -j8 CORE=${CORE} MCU=${MCU} CONFIG=IAP_SPI_LOADER MAKE_DIR=IAP/makefiles/${MCU} all
if [ -f ./iapbuild/${MCU,,}_iap_SBC.bin ]; then
    mv ./iapbuild/${MCU,,}_iap_SBC.bin ${OUTPUT}/${MCU,,}_iap_SBC.bin
    mv ./iapbuild/${MCU,,}_iap_SBC.map ${OUTPUT}/${MCU,,}_iap_SBC.map
    (cd ${OUTPUT}; /c/Windows/SysWOW64/tar.exe -a -c -f firmware-${MCU,,}-${NETWORK,,}-${VER,,}.zip firmware-${MCU,,}-${NETWORK,,}-${VER,,}.bin ${MCU,,}_iap_SBC.bin)
fi 
