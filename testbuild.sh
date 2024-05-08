#!/bin/sh
echo $1 $2 $3 $4 $5 $6 $7 $8 $9
if [ "$#" -lt 7 ]; then
  echo "Usage: $0 BUILDTYPE CORE MCU MCU_VARIANT NETWORK OEM BOARDNAME OEM [BOOT_DELAY] [CRC]" >&2
  exit 1
fi

echo $1 $2 $3 $4 $5 $6 $7 $8 $9
BUILD=$1
CORE=$2
MCU=$3
VARIANT=$4
NETWORK=$5
OEM=$6
BOARD=$7
STARTUP_DELAY=${8:--DSTARTUP_DELAY=10000}
CRC=${9:-RepRapFirmware/Tools/CrcAppender/win-x86-64/CrcAppender.exe}

OUTPUT="firmware_${BOARD}.bin"

make -j8 firmware CORE=${CORE} MCU=${MCU} NETWORK=${NETWORK} BUILD=${BUILD} VARIANT=${VARIANT} STARTUP_DELAY=${STARTUP_DELAY} OUTPUT_NAME=base_${VARIANT,,}
if [ -f ./build/base_${VARIANT,,}.bin ]; then
    cp ./build/base_${VARIANT,,}.bin build/${OUTPUT}
    ${CRC} ./build/${OUTPUT} boards/${OEM}/${BOARD}
fi 
