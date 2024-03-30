#!/bin/sh
if [ "$#" -lt 6 ]; then
  echo "Usage: $0 BUILDTYPE CORE MCU MCU_VARIANT NETWORK OUTNAME [BOOT_DELAY]" >&2
  exit 1
fi
echo $1 $2 $3 $4 $5 $6 $7
BUILD=$1
CORE=$2
MCU=$3
VARIANT=$4
NETWORK=$5
OUTNAME=$6
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

make distclean MAKE_DIR=IAP/makefiles/${MCU}
make -j8 CORE=${CORE} MCU=${MCU} VARIANT=${VARIANT} CONFIG=IAP_SPI_LOADER MAKE_DIR=IAP/makefiles/${MCU} OUTPUT_NAME=${OUTNAME} all
if [ -f ./iapbuild/${OUTNAME}.bin ]; then
    mv ./iapbuild/${OUTNAME}.bin ${OUTPUT}/base/${OUTNAME}.bin
    mv ./iapbuild/${OUTNAME}.map ${OUTPUT}/map/${OUTNAME}.map
fi 
