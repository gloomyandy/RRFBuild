#!/bin/sh
echo $1 $2 $3 $4 $5 $6
BUILD=${1:-Debug}
PROCESSOR=${2:-RP2040}
BOARD=${3:-FLY36RRF}
BOARD_REV=${4:-0}
CANFLAGS=${5:--DUSE_SPICAN}
BOARDNAME=${6:-FLY36RRF}
#extract firmware version from header file
VER=`awk 'sub(/.*MAIN_VERSION/,""){print $1}' RepRapFirmware/src/Version.h  | awk 'gsub(/"/, "", $1)'`

OUTPUT=releases/${VER}/${BUILD}

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
