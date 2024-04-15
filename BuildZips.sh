#!/bin/sh
echo $1
BUILD=${1:-Debug}
#extract firmware version from header file
VER=`awk 'sub(/.*MAIN_VERSION/,""){print $1}' RepRapFirmware/src/Version.h  | awk 'gsub(/"/, "", $1)'`

OUTPUT=releases/${VER}
mkdir -p ${OUTPUT}
rm -f ${OUTPUT}/*.zip
rm -rf ziptmp
mkdir -p ziptmp
# Now copy over the mainboard files
for oem in ${OUTPUT}/mainboard/*; do
    for board in ${oem}/*.bin; do
        cp ${board} ziptmp
    done
done
# And the toolboards
cp ${OUTPUT}/expansion/* ziptmp
# remove picocan boards
rm ziptmp/*_picocan.uf2
# create the SBC zip
(cd ziptmp; /c/Windows/SysWOW64/tar.exe -a -c -f ../${OUTPUT}/STM32RepRapFirmwareSBC.zip *)

# Add in the wifi firmware
cp ${OUTPUT}/wifi/*/* ziptmp
# prepare DWC
if [ -f DuetWebControl/dist/DuetWebControl-SD.zip ]; then
  cp DuetWebControl/dist/DuetWebControl-SD.zip ziptmp
  (cd ziptmp; /c/Windows/SysWOW64/tar.exe xvf DuetWebControl-SD.zip; rm DuetWebControl-SD.zip)
fi
# now zip it all up
(cd ziptmp; /c/Windows/SysWOW64/tar.exe -a -c -f ../${OUTPUT}/STM32RepRapFirmwareWiFi.zip *)
rm -rf ziptmp