#!/bin/sh
if [ "$#" -ne 6 ]; then
  echo "Usage: $0 BUILDTYPE PROCESSOR BOARD BOARD_REV CAN_FLAGS BOARDNAME" >&2
  exit 1
fi
echo $1 $2 $3 $4 $5 $6
BUILD=$1
PROCESSOR=$2
BOARD=$3
BOARD_REV=$4
CANFLAGS=$5
BOARDNAME=$6
#extract firmware version from header file
VER=`awk 'sub(/.*MAIN_VERSION/,""){print $1}' RepRapFirmware/src/Version.h  | awk 'gsub(/"/, "", $1)'`

OUTPUT=releases/${VER}

mkdir -p ${OUTPUT}
mkdir -p ${OUTPUT}/expansion
mkdir -p ${OUTPUT}/map
rm -f ${OUTPUT}/map/${BOARDNAME}.*
rm -f ${OUTPUT}/expansion/${BOARDNAME}.*

make distclean MAKE_DIR=Duet3Expansion/makefiles
make -j8 BUILD=${BUILD} PROCESSOR=${PROCESSOR} BOARD=${BOARD} BOARD_REV=${BOARD_REV} CANFLAGS=${CANFLAGS} MAKE_DIR=Duet3Expansion/makefiles OUTPUT_NAME=Duet3Firmware_${BOARDNAME} all
if [ -f ./expbuild/Duet3Firmware_${BOARDNAME}.uf2 ]; then
    mv ./expbuild/Duet3Firmware_${BOARDNAME}.uf2 ${OUTPUT}/expansion/Duet3Firmware_${BOARDNAME}.uf2
    mv ./expbuild/Duet3Firmware_${BOARDNAME}.map ${OUTPUT}/map/Duet3Firmware_${BOARDNAME}.map
fi 
