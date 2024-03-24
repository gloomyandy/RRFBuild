#!/bin/sh
echo $1 $2 $3 $4 $5 $6 $7 $8
BUILD=${1:-Debug}
MCU=${2:-STM32F4}
NETWORK=${3:-WIFI}
BOARD=$4
INNAME=${5:-firmware-${MCU,,}-${NETWORK,,}}
OUTNAME=${6:-firmware-${BOARD,,}-${NETWORK,,}}
IAP=${7:-${MCU,,}_iap_SBC}
CRC=${8:-RepRapFirmware/Tools/CrcAppender/win-x86-64/CrcAppender.exe}
#extract firmware version from header file
VER=`awk 'sub(/.*MAIN_VERSION/,""){print $1}' RepRapFirmware/src/Version.h  | awk 'gsub(/"/, "", $1)'`

OUTPUT=releases/${VER}/${BUILD}
echo $INNAME $OUTNAME
mkdir -p ${OUTPUT}
mkdir -p ${OUTPUT}/mainboard
rm -f ${OUTPUT}/mainboard/${OUTNAME}.*

if [ -f ${OUTPUT}/base/$INNAME.bin ]; then
        cp ${OUTPUT}/base/$INNAME.bin ${OUTPUT}/mainboard/$OUTNAME.bin
        ${CRC} ${OUTPUT}/mainboard/$OUTNAME.bin boards/$BOARD
        if [ ${NETWORK} != "WIFI" ]; then
            (cd ${OUTPUT}/mainboard; /c/Windows/SysWOW64/tar.exe -a -c -f ${OUTNAME}.zip ${OUTNAME}.bin ${IAP}.bin)
        fi
fi 
