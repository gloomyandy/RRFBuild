#!/bin/sh
echo $1 $2 $3 $4 $5
BUILD=${1:-Debug}
PROCESSOR=${2:-RP2040}
BOARD=${3:-FLY36RRF}
CANFLAGS=${4:--DUSE_SPICAN}
TAG=$5
#extract firmware version from header file
VER=`awk 'sub(/.*MAIN_VERSION/,""){print $1}' RepRapFirmware/src/Version.h  | awk 'gsub(/"/, "", $1)'`

OUTPUT=releases/${VER}/${BUILD}

mkdir -p ${OUTPUT}
rm -f ${OUTPUT}/${BOARD}-${TAG}.*

make distclean MAKE_DIR=Duet3Expansion/makefiles
make -j8 BUILD=${BUILD} PROCESSOR=${PROCESSOR} BOARD=${BOARD} CANFLAGS=${CANFLAGS} MAKE_DIR=Duet3Expansion/makefiles all
if [ -f ./expbuild/Duet3Firmware_${BOARD}.uf2 ]; then
    mv ./expbuild/Duet3Firmware_${BOARD}.uf2 ${OUTPUT}/Duet3Firmware_${BOARD}${TAG}.uf2
    mv ./expbuild/Duet3Firmware_${BOARD}.map ${OUTPUT}/Duet3Firmware_${BOARD}${TAG}.map
fi 
