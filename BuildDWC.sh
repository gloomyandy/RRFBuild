#!/bin/sh
if [ -f DuetWebControl-SD.zip ]; then
    echo "Using pre-built DWC"
elif [ -f DuetAPI.xml ]; then
    cp DuetAPI.xml DuetWebControl
    (cd DuetWebControl; npm run build)
    rm DuetWebControl/DuetAPI.xml
else
    echo "DuetAPI.xml not found"
fi