#!/bin/sh
if [ "$#" -lt 8 ]; then
  echo "Usage: $0 BUILDTYPE MCU NETWORK BOARDDIR BOARDNAME BASENAME OUTNAME IAPNAME [CRC_PROG]" >&2
  exit 1
fi
echo $1 $2 $3 $4 $5 $6 $7 $8 $9
BUILD=$1
MCU=$2
NETWORK=$3
DIR=$4
BOARD=$5
INNAME=$6
OUTNAME=$7
IAP=$8
CRC=${9:-RepRapFirmware/Tools/CrcAppender/win-x86-64/CrcAppender.exe}
#extract firmware version from header file
VER=`awk 'sub(/.*MAIN_VERSION/,""){print $1}' RepRapFirmware/src/Version.h  | awk 'gsub(/"/, "", $1)'`

OUTPUT=releases/${VER}/${BUILD}
echo $INNAME $OUTNAME
mkdir -p ${OUTPUT}
mkdir -p ${OUTPUT}/mainboard/${DIR}
rm -f ${OUTPUT}/mainboard/${DIR}/${OUTNAME}.*

if [ -d boards/${DIR}/${BOARD} ]; then
    if [ -f ${OUTPUT}/base/${INNAME}.bin ]; then
            cp ${OUTPUT}/base/${INNAME}.bin ${OUTPUT}/mainboard/${DIR}/$OUTNAME.bin
            cp ${OUTPUT}/base/${IAP}.bin ${OUTPUT}/mainboard/${DIR}/$IAP.bin
            ${CRC} ${OUTPUT}/mainboard/${DIR}/${OUTNAME}.bin boards/${DIR}/${BOARD}
            if [ ${NETWORK} != "WIFI" ]; then
                (cd ${OUTPUT}/mainboard/${DIR}; /c/Windows/SysWOW64/tar.exe -a -c -f ${OUTNAME}.zip ${OUTNAME}.bin ${IAP}.bin)
            fi
    fi 
fi
