#!/bin/sh
if [ -f DuetWebControl-SD.zip ]; then
    echo "Using pre-built DWC"
else
    (cd DuetWebControl; npm install; npm run build)
fi