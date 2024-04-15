#!/bin/sh
if [ "$#" -lt 6 ]; then
  echo "Usage: $0 BUILDTYPE CORE MCU MCU_VARIANT NETWORK BOARDNAME OUTNAME [BOOT_DELAY]" >&2
  exit 1
fi

echo $1 $2 $3 $4 $5 $6 $7
BUILD=$1
CORE=$2
MCU=$3
VARIANT=$4
NETWORK=$5
OUTNAME=$6
STARTUP_DELAY=$7
#extract firmware version from header file
VER=`awk 'sub(/.*MAIN_VERSION/,""){print $1}' RepRapFirmware/src/Version.h  | awk 'gsub(/"/, "", $1)'`

OUTPUT=releases/${VER}
echo $OUTNAME
mkdir -p ${OUTPUT}
mkdir -p ${OUTPUT}/base
mkdir -p ${OUTPUT}/map
rm -f ${OUTPUT}/base/${OUTNAME}.*
rm -f ${OUTPUT}/map/${OUTNAME}.*

make distclean
make -j8 firmware CORE=${CORE} MCU=${MCU} NETWORK=${NETWORK} BUILD=${BUILD} VARIANT=${VARIANT} STARTUP_DELAY=${STARTUP_DELAY} OUTPUT_NAME=${OUTNAME}
if [ -f ./build/${OUTNAME}.bin ]; then
        mv ./build/${OUTNAME}.bin ${OUTPUT}/base/$OUTNAME.bin
        mv ./build/${OUTNAME}.map ${OUTPUT}/map/$OUTNAME.map
fi 
