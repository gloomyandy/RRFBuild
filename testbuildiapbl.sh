#!/bin/sh
if [ "$#" -ne 6 ]; then
  echo "Usage: $0 BUILDTYPE CORE MCU VARIANT BOARDDIR BOARD" >&2
  exit 1
fi
echo $1 $2 $3 $4 $5
BUILD=$1
CORE=$2
MCU=$3
VARIANT=$4
DIR=$5
BOARD=$6
#extract firmware version from header file
VER=`awk 'sub(/.*MAIN_VERSION/,""){print $1}' RepRapFirmware/src/Version.h  | awk 'gsub(/"/, "", $1)'`

if [ -d boards/${DIR}/${BOARD} ]; then
  # get board specific stuff
  SDTYPE=`awk -f getvalue.awk boards/${DIR}/${BOARD}/rrfboot.txt sdcard.internal.type I 255`
  LED=`awk -f getpin.awk boards/${DIR}/${BOARD}/rrfpins.txt status NoPin`
  CANREAD=`awk -f getvalue.awk boards/${DIR}/${BOARD}/rrfboot.txt can.readPin P PB_8`
  CANWRITE=`awk -f getvalue.awk boards/${DIR}/${BOARD}/rrfboot.txt can.writePin P PB_9`
  CAN_ADDRESS=`awk -f getvalue.awk boards/${DIR}/${BOARD}/rrfboot.txt can.exp.address I 119`
  if [ $SDTYPE -ne 255 ]; then
    USE_SD=1
  else
    USE_SD=0
  fi
  echo boards/${DIR}/${BOARD}/rrfboot.txt $SDTYPE $LED $CANREAD

  USE_CAN=1
  OUTNAME=bootloader_${BOARD}
  #make distclean MAKE_DIR=IAP/makefiles/${MCU}
  make -j8 CORE=${CORE} MCU=${MCU} CONFIG=IAP_BOOT_LOADER USE_SD=${USE_SD} USE_CAN=${USE_CAN} SDTYPE=${SDTYPE} LED_PIN=${LED} CAN_READ=${CANREAD} CAN_WRITE=${CANWRITE} CAN_ADDRESS=${CAN_ADDRESS} BOARD_NAME=${BOARD} MAKE_DIR=IAP/makefiles/${MCU} VARIANT=${VARIANT} OUTPUT_NAME=${OUTNAME} all
else
  echo "Board" $DIR " " $BOARD " not found"
fi