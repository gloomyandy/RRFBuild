#!/bin/sh
if [ "$#" -ne 6 ]; then
  echo "Usage: $0 BUILDTYPE CORE MCU SDTYPE" >&2
  exit 1
fi
echo $1 $2 $3 $4
BUILD=$1
CORE=$2
MCU=$3
VARIANT=$4
SDTYPE=$5
OUTNAME=$6
#extract firmware version from header file
VER=`awk 'sub(/.*MAIN_VERSION/,""){print $1}' RepRapFirmware/src/Version.h  | awk 'gsub(/"/, "", $1)'`

OUTPUT=releases/${VER}/${BUILD}

mkdir -p ${OUTPUT}
mkdir -p ${OUTPUT}/map
mkdir -p ${OUTPUT}/base
rm -f ${OUTPUT}/map/${OUTNAME}.*
rm -f ${OUTPUT}/base/${OUTNAME}.*

make distclean MAKE_DIR=IAP/makefiles/${MCU}
make -j8 CORE=${CORE} MCU=${MCU} CONFIG=IAP_BOOT_LOADER SDTYPE=${SDTYPE} MAKE_DIR=IAP/makefiles/${MCU} VARIANT=${VARIANT} OUTPUT_NAME=${OUTNAME} all
if [ -f ./iapbuild/${OUTNAME}.bin ]; then
    mv ./iapbuild/${OUTNAME}.bin ${OUTPUT}/base/${OUTNAME}.bin
    mv ./iapbuild/${OUTNAME}.map ${OUTPUT}/map/${OUTNAME}.map
fi 
